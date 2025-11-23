import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from pathlib import Path
import os

class DataLoader:
    def __init__(self, data_path: str = 'data/raw/creditcard.csv'):
        self.data_path = Path(data_path)
    
    def load_data(self) -> pd.DataFrame:
        print("loading data")
        df = pd.read_csv(self.data_path)
        return df
    
    def create_splits(self, df: pd.DataFrame, test_size: float = 0.2, val_size: float = 0.1):
        
        train_val, test = train_test_split(               
            df, 
            test_size=test_size, 
            stratify=df['Class'],
            random_state=42
        )
        
        val_size_adjusted = val_size / (1 - test_size)          
        train, val = train_test_split(
            train_val,
            test_size=val_size_adjusted,
            stratify=train_val['Class'],
            random_state=42
        )
        print(f"\nTrain set: {len(train)} ({train['Class'].sum()} frauds)")
        print(f"Val set: {len(val)} ({val['Class'].sum()} frauds)")
        print(f"Test set: {len(test)} ({test['Class'].sum()} frauds)")
        

        file_path = Path(__file__).resolve()
        project_root = file_path.parent.parent.parent  
        if not (project_root / 'src').exists():
            current_path = Path.cwd()
            project_root = current_path
            while project_root != project_root.parent:
                if (project_root / 'src').exists():
                    break
                project_root = project_root.parent
        processed_dir = project_root / 'data' / 'processed'
        processed_dir.mkdir(parents=True, exist_ok=True)
        
        print(f"Saving splits to: {processed_dir}")
        train.to_csv(processed_dir / 'train.csv', index=False)
        val.to_csv(processed_dir / 'validation.csv', index=False)
        test.to_csv(processed_dir / 'test.csv', index=False)
        
        return train, val, test

if __name__ == "__main__":

    try:
        loader = DataLoader()
        df = loader.load_data()
        loader.create_splits(df)
    except FileNotFoundError:
        print("error.")
