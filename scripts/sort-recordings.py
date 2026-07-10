import os
import shutil


dir = "/mnt/Shares/Private/Recordings/"


def moveRecording(date: str, file: str):
    print(f"Moving: {file}")
    shutil.move(dir+file, dir+date+"/"+file)


def datedDirExists(date: str):
    if date not in os.listdir(dir):
        os.mkdir(dir + date)


def splitFileName(file: str) -> list[str]:
    return file.split("_")


def loopRecordings():
    for item in os.listdir(dir):
        if os.path.isfile(os.path.join(dir, item)):
            splitName = splitFileName(item)
            datedDirExists(splitName[0])
            moveRecording(splitName[0], item)


def main():
    loopRecordings()


if __name__ == "__main__":
    main()
