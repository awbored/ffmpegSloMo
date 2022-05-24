# ffmpegSloMo
ffmpeg script to slow down videos

Requirements:
*ffmpeg
*bash/linux terminal

I'm mainly backing this up here, since it's a linux bash script.

I may eventually update to Python (meh?!)

Steps:

*Run ffmpegSloMo.sh once to create folders (Make executable if needed: 'chmod +x ffmpegSloMo.sh')
*Drop movie files into ./Movies
*Run script again

To keep the CPU from overheating, I have a 30 second timer in between each encode.
