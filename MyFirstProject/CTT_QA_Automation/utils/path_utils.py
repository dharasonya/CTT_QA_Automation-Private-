'''
Created on 08-Jun-2025

@author: sonyarani.dhara
'''
import os

class readConfigFile:
    """Utility class for handling project directory paths."""
    
    @staticmethod
    def get_project_file_path(end_path):
        """Get the correct project directory path dynamically."""
        project_directory = os.path.dirname(os.path.abspath(__file__))

        
        if os.path.basename(project_directory) != "CTT_QA_Automation":
            project_directory = os.path.dirname(project_directory)  # Move one level up

        return os.path.join(project_directory, end_path)
