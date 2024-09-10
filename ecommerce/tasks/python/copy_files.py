import os
import pwd
import shutil
from airflow.models import Variable

# Fetch variables from Airflow
source_dir = Variable.get("source_dir")
target_dir = Variable.get("target_dir")

# List of folder names
folders = [
    'category_translation',
    'customer',
    'geolocation',
    'order_items',
    'order_payments',
    'order_reviews',
    'orders',
    'products',
    'sellers'
]

def copy_files():
    # Print the current user
    current_user = pwd.getpwuid(os.getuid()).pw_name
    print(f"Current user: {current_user}")

    for folder in folders:
        source_folder_path = os.path.join(source_dir, folder)
        target_folder_path = os.path.join(target_dir, folder)

        print(f"Source folder path: {source_folder_path}")
        print(f"Target folder path: {target_folder_path}")

        # Check if target directory exists
        try:
            if not os.path.exists(target_folder_path):
                os.makedirs(target_folder_path, exist_ok=True)  # Use exist_ok=True to avoid race conditions
                print(f"Created target folder: {target_folder_path}")
            else:
                print(f"Target folder already exists: {target_folder_path}")

            # Search for CSV files in the source folder
            for file_name in os.listdir(source_folder_path):
                if file_name.endswith('.csv'):
                    source_file_path = os.path.join(source_folder_path, file_name)
                    target_file_path = os.path.join(target_folder_path, file_name)

                    shutil.copy(source_file_path, target_file_path)
                    print(f"Copied {source_file_path} to {target_file_path}")
                else:
                    print(f"Skipping non-CSV file in {source_folder_path}: {file_name}")
        
        except PermissionError as e:
            print(f"Permission denied: {e}")
        except Exception as e:
            print(f"Error while processing {folder}: {e}")

if __name__ == "__main__":
    copy_files()
