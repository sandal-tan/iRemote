--
--  iRemoteAppDelegate.applescript
--  iRemote
--
--  Created by Ian Baldwin on 5/26/11.
--  Copyright 2011 BaldwinSoft. All rights reserved.
--

script iRemoteAppDelegate
	property parent : class "NSObject"
    property searchAdvanced : missing value
    property playlistAdvanced : missing value
    
    ---Playlist (Advanced)
    on playPlaylistAdvanced_(sender)
        set playlistValue to playlistAdvanced's stringvalue() as text
        set plist2play to playlistValue
        try
            tell application "iTunes"
                play playlist (plist2play)
            end tell
            on error number Err
            if Err is -1728 then
                tell application "iRemote"
                    activate
                    display dialog "No Results Found, please try again." with icon 2
                end tell
            end if
        end try
    end playPlaylistAdvanced_

    
    ---Next track
    on preformclickNext_(aNotification)
        tell application "iTunes" to (next track)
    end preformclickNext_
    
    ---Play/Pause
    on preformclickPP_(aNotification)
        tell application "iTunes" to playpause
    end preformclickPP_
    
    ---Previous track
    on preformclickPrevious_(aNotification)
        tell application "iTunes" to (previous track)
    end preformclickPrevious_
	
    ---Search (Advanced)
    on searchAdvanced_(sender)
        set searchValue to searchAdvanced's stringValue() as text
        set song2play to searchValue
        try
            
            tell application "iTunes"
                play first item of (search first library playlist for (song2play))
            end tell
            on error number Err
            if Err is -1728 then
                tell application "iRemote"
                    activate
                    display dialog "No Results Found, please try again." with icon 2
                end tell
            end if
        end try
    end searchAdvanced_

    
	on applicationWillFinishLaunching_(aNotification)
        tell application "iTunes"
            if player state is paused then
                tell application "iRemote"
                    activate
                    set song to (display dialog "What would you like to hear?" default answer "" buttons {"Find and Play", "Cancel"} default button 1 with icon 1)
                    if button returned of song is "Cancel"
                end if 
                set song2play to the text returned of song
                try
                    tell application "iTunes"
                        play first item of (search first library playlist for (text returned of song))
                    end tell
                    
                    on error
                        tell application "iRemote"
                            activate
                            display dialog "No Results found, please try again" with icon 2
                        end tell
                    end try
                end tell
            end if
        end tell
    
    tell application "iTunes"
        if player state is stopped then
            tell application "iRemote"
                activate
                    set song to (display dialog "What would you like to hear?" default answer "" buttons {"Find and Play", "Cancel"} default button 1 with icon 1)
                if button returned of song is "Cancel"
            end if 
                set song2play to the text returned of song
            try
                tell application "iTunes"
                    play first item of (search first library playlist for (text returned of song))
                end tell
            on error
                tell application "iRemote"
                    activate
                        display dialog "No Results found, please try again" with icon 2
                end tell
            end try
        end tell
    end if
end tell

    tell application "iTunes"
        if shuffle of playlist (index of last playlist) is true then
            tell application "iRemote"
                activate
                display dialog "Shuffle is currently on. Would you like to turn it off" buttons {"Yes", "No"} with icon 2
                if button returned of the result is "Yes" then
                    tell application "iTunes"
                        repeat with i from 1 to (index of last playlist)
                    try
                        set shuffle of playlist i to false
                    end try
                end repeat
            end tell
        end if
    end tell
end if
end tell
end applicationWillFinishLaunching_


    

    
            
	
	on applicationShouldTerminate_(sender)
		-- Insert code here to do any housekeeping before your application quits 
		return current application's NSTerminateNow
	end applicationShouldTerminate_
	
end script