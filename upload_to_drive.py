from googleapiclient.discovery import build
from googleapiclient.http import MediaFileUpload
from google_auth_oauthlib.flow import InstalledAppFlow
from google.auth.transport.requests import Request
from google.oauth2.credentials import Credentials
import os

# 如果修改了这些作用域，则删除 token.json。
SCOPES = ['https://www.googleapis.com/auth/drive']

def main():
    creds = None
    # token.json 存储用户的访问和刷新令牌，使用 credentials.json 创建。
    if os.path.exists('token.json'):
        creds = Credentials.from_authorized_user_file('token.json', SCOPES)
    # 如果没有有效的凭据，请让用户登录。
    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
        else:
            flow = InstalledAppFlow.from_client_secrets_file(
                'credentials.json', SCOPES)
            creds = flow.run_local_server(port=0)
        # 保存凭据以备下次运行
        with open('token.json', 'w') as token:
            token.write(creds.to_json())

    service = build('drive', 'v3', credentials=creds)

    # 文件上传部分
    file_metadata = {'Dybrage.zip'}
    media = MediaFileUpload('文件路径', mimetype='zip')
    file = service.files().create(body=file_metadata, media_body=media, fields='id').execute()
    print('File ID: %s' % file.get('id'))

if __name__ == '__main__':
    main()
