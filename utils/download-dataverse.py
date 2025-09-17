# https://guides.dataverse.org/en/latest/api/dataaccess.html#downloading-all-files-in-a-dataset
# The basic form downloads files from the latest accessible version of the dataset. 
# If you are not using an API token, this means the most recently published version. 
# If you are using an API token with full access to the dataset, this means the draft version or the most recently published version if no draft exists.

import os
import requests
import zipfile

## SET WD

wdir = os.getcwd()
# wdir = wdir.replace("\\", "/") # replace slashes for windows 
wdir = wdir.replace("", "") # strip relative path of this file

os.chdir(wdir)
os.getcwd() # check

def download_dataverse(persistent_id, directory_path):
    server_url = 'https://dataverse.harvard.edu/'
    persistent_id = persistent_id

    # Make new directory to store response
    os.makedirs(directory_path, exist_ok=True)
    
    # Construct the API URL
    api_url = f'{server_url}/api/access/dataset/:persistentId/?persistentId={persistent_id}'

    # Send the request
    response = requests.get(api_url)

    # Save the zip file
    if response.status_code == 200:
        content_disposition = response.headers.get('content-disposition')
        filename = content_disposition.split('filename=')[1].strip('\"')
        file_path = os.path.join(directory_path, filename)
        with open(file_path, 'wb') as file:
            file.write(response.content)
            print(f"File '{filename}' downloaded and saved successfully.")

        # Extract the zip file
        with zipfile.ZipFile(file_path, 'r') as zip_ref:
            zip_ref.extractall(directory_path)
            print("Zip file extracted successfully.")
    else:
        print('Error occurred while downloading the file.')

    # Delete the zip file
    os.remove(file_path)
    print("Zip file deleted successfully.")


download_dataverse(persistent_id = 'doi:10.7910/DVN/IG0UN2', directory_path = 'data/raw')
