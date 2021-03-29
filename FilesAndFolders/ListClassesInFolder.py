from os import walk
from os.path import isfile, join, isdir, splitext
import pyperclip #to use: pip install pyperclip
pathToFetchFrom = input("Enter path to directory from which class names should be fetched (subdirectories included): ")
if not isdir(pathToFetchFrom):
    print("Directory could not be found!")
else:
    listOfFiles = list()
    for (r, d, f) in walk(pathToFetchFrom):
        listOfFiles += [file for file in f if isfile(join(r, file))]
    classNameCandidates = [splitext(candidate)[0] for candidate in listOfFiles if candidate.endswith(".h") or candidate.endswith(".cpp") or candidate.endswith(".cs")]
    if not classNameCandidates:
        print("No classes found!")
    else:
        uniqueClassNameCandidates = list(dict.fromkeys(classNameCandidates))
        formatThemForConfluence = input("Do you want them to be formatted for Confluence pasting (via insert markup)? y/n: ")
        copyToClipBoard = input("Do you want the list to be copied to the clipboard? y/n: ")
        if formatThemForConfluence.lower() == "y":
            uniqueClassNameCandidates = ["* *" + name + "*: " for name in uniqueClassNameCandidates]
        finishedList = "\n".join(uniqueClassNameCandidates)
        print(finishedList)
        if copyToClipBoard.lower() == "y":
            pyperclip.copy(finishedList)