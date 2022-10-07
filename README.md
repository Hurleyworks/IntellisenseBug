# IntellisenseBug
Intellisense is not working properly on an amalgamated source file in vs2022. Same project works fine in vs2019

--Steps to Compile

1. run the "generateVS2022.bat" file 
2. go to the newly created "builds" folder
3. open the IntellisenseBud.sln file inside the VisualStudio2022 folder

-- Steps to Reproduce

4. open the "framework/minimal_core/excludeFromBuild/ActiveMinimal.cpp file
5. note the intellisense errors on lines 10 and 30.

6. Repeat above steps using "generateVS2019.bat" file 
7. note that there are no Intellisense errors

