# Long Distance Widgets

## Introduction 
Created iOS widgets using Swift and Widget toolkit on Xcode bringing prototypes on Figma to life. A collaborative project with Phillip Vedder and Hana Ahmed-Mahmoud, met during Hana's time on exchange at the University of Auckland. 

## Figma Prototypes 
<img width="429" height="682" alt="Screenshot 2025-09-05 at 12 11 36" src="https://github.com/user-attachments/assets/999bf0ed-cc78-445e-b84b-d2fddf56da99" />

### Final chosen design:
<img width="547" height="145" alt="Screenshot 2025-09-05 at 12 10 19" src="https://github.com/user-attachments/assets/96338dda-36ce-4fbc-ba3c-aede36d64be5" />

## Development Diary 
### 05/09/2025
- Set up project on github and on Xcode 
- Taught Phillip github commands, for his reference:
  - git clone "link" -> adds repository to your main computer, only need to do this once. For the rest of the commands locate the folder in terminal
  - git add . -> adds all folders/ new files/ assets you created 
  - git commit -am "message -Name" -> creates a commit ready to push up to github
  - git push -> pushes all your work to github
  - git pull -> pulls down any changes i make or if you want the most updated version on computer 
- Initial coding of prototype completed by Hana, need to work on sorting out offsets

### 15/09/2025
- Project structure will be as follows: Widget Entry, Widget Provider, Widget View (using widget entry), Widget Definitions (gluing both provider and view together), Phillip and Hana to create a diagram together to demonstrate how structures communicate with eachother 
- Created each data structure for both distance and timer widgets
- Finished Widget View for both distance and timer widgets, ready for customistion based on distance and time from when two people first met
- Added fonts onto app (had to change the Noricon-Regular font to LeckerliOne as Noricon was a little dodgy
- Added new assets for timer widget 
- Added previews for both distance and timer widgets (comment out which one you don't want to see) 
- Changed Widget Bundle to include both distance and timer widgets
- Hana to talk Phillip through the changes

### 16/09/2025
- Hana started plane animation on distance widget, to be improved upon
- Attempted a gif approach, then attempted a frame by frame approach which seems to work better 

### 17/09/2025
- HANA FINISHED THE PLANE ANIMATION!!!!!!
- Need to fix bug which isnt allowing widget to be played on phone
