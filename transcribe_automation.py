import boto3
import time
import json
import requests
import sys
import os
from datetime import datetime
from botocore.exceptions import ClientError

SUPPORTED_MEDIA_FORMATS = {"mp3", "mp4", "wav", "flac", "ogg", "amr", "webm"}

def ensure_file_in_s3(s3_client, bucket, media_file_path):
    """Check if file exists in S3. If not, upload it from local path."""
    file_key = os.path.basename(media_file_path)

    try:
        s3_client.head_object(Bucket=bucket, Key=file_key)
        print(f"✅ File already exists in S3: s3://{bucket}/{file_key}")
    except ClientError as e:
        if e.response['Error']['Code'] == '404':
            print(f"📤 Uploading {file_key} to s3://{bucket}/ ...")
            s3_client.upload_file(media_file_path, bucket, file_key)
            print("✅ Upload complete.")
        else:
            raise

    return file_key

def start_transcription_job(job_name, bucket, media_file_path, language_code="en-US"):
    s3 = boto3.client('s3')
    transcribe = boto3.client('transcribe')

    # Clean and validate extension
    file_ext = os.path.splitext(media_file_path)[1][1:].lower()
    if file_ext not in SUPPORTED_MEDIA_FORMATS:
        print(f"❌ Unsupported media format: '{file_ext}'. Must be one of: {', '.join(SUPPORTED_MEDIA_FORMATS)}")
        sys.exit(1)

    # Ensure file is uploaded to S3 if not already there
    file_key = ensure_file_in_s3(s3, bucket, media_file_path)
    file_uri = f"s3://{bucket}/{file_key}"

    print(f"🚀 Starting transcription job: {job_name}")
    transcribe.start_transcription_job(
        TranscriptionJobName=job_name,
        Media={'MediaFileUri': file_uri},
        MediaFormat=file_ext,
        LanguageCode=language_code
    )

    # Wait for job to complete
    while True:
        status = transcribe.get_transcription_job(TranscriptionJobName=job_name)
        job_status = status['TranscriptionJob']['TranscriptionJobStatus']
        print(f"📡 Job status: {job_status}")

        if job_status in ['COMPLETED', 'FAILED']:
            break
        time.sleep(10)

    if job_status == 'COMPLETED':
        transcript_url = status['TranscriptionJob']['Transcript']['TranscriptFileUri']
        print(f"✅ Transcript available at the transcribe console.")

        response = requests.get(transcript_url)
        transcript_data = response.json()
        transcript_text = "\n".join(t['transcript'] for t in transcript_data['results']['transcripts'])

        # Generate timestamped output
        timestamp = datetime.now().strftime("%Y-%m-%d_%H%M")
        final_file_name = os.path.splitext(file_key)[0]
        output_file = f"{final_file_name}-{timestamp}.txt"

        with open(output_file, 'w') as f:
            f.write(transcript_text)

        print(f"📝 Transcript saved to: {output_file}")
    else:
        print("❌ Transcription job failed.")
        print(json.dumps(status, indent=2))


if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Usage: python transcribe_automation.py <bucket_name> <local_media_file_path>")
        sys.exit(1)

    bucket_name = sys.argv[1]
    local_media_path = sys.argv[2]
    job_name = f"TranscriptionJob-{int(time.time())}"

    start_transcription_job(job_name, bucket_name, local_media_path)
