--
--  iRemoteAppDelegate.applescript
--  iRemote
--
--  Created by Ian Baldwin on 6/6/11.
--  Copyright 2011 BaldwinSoft. All rights reserved.
--

script iRemoteAppDelegate
	property parent : class "NSObject"
    property searchAdvanced : missing value
	
	on applicationWillFinishLaunching_(aNotification)
		-- Insert code here to initialize your application before any files are opened 
	end applicationWillFinishLaunching_
   
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
    
    ---Search (Advanced)
    on searchAdvanced_(aNotification)
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


	
	on applicationShouldTerminate_(sender)
		-- Insert code here to do any housekeeping before your application quits 
		return current application's NSTerminateNow
	end applicationShouldTerminate_
	
end script