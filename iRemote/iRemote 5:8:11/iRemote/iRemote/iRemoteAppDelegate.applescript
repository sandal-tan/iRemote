--
--  iRemoteAppDelegate.applescript
--  iRemote
--
--  Created by Ian Baldwin on 5/8/11.
--  Copyright 2011 BaldwinSoft. All rights reserved.
--

script iRemoteAppDelegate
	property parent : class "NSObject"
    property textField : missing value
    property textField2 : missing value
    property textField3 : missing value
    property textField4 : missing value
    
    on setTextViewFromTextField4_(sender)
        set textField4Value to textField4's stringvalue() as text
        set song2play to textField2Value
        try
            tell application "iTunes"
                play playlist (song2play)
            end tell
            on error number Err
            if Err is -1728 then
                tell application "iRemote"
                    activate
                    display dialog "No Results Found, please try again." with icon 2
                end tell
            end if
        end try
    end setTextViewFromTextField4_
    
    on performclickDO_(aNotification)
        tell application "iTunes"
            set cur_song to (name of current track) as text
            set cur_artist to (artist of current track) as text
            tell application "iRemote"
                set dplist to (display dialog "What playlist would you like to add " & cur_song & " by " & cur_artist & " to?" with icon 1 buttons {"Add", "Create New", "Cancel"} default button 1 default answer "")
                set dpl to text returned of dplist
                if button returned of dplist is "Add" then
                    tell application "iTunes"
                        set currentList to playlist dpl
                        add (get location of current track) to currentList
                    end tell
                    else if button returned of dplist is "Create New" then
                    tell application "iTunes"
                        make new playlist with properties {name:dpl}
                        set currentList to playlist dpl
                        add (get location of current track) to currentList
                    end tell
                end if
            end tell
        end tell
    end performclickDO_  
    
	
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

    
    on setTextViewFromTextField_(sender)
        set textFieldValue to textField's stringValue() as text
        set song2play to textFieldValue
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
           end setTextViewFromTextField_


    on setTextViewFromTextField2_(sender)
        set textField2Value to textField2's stringvalue() as text
        set song2play to textField2Value
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
    end setTextViewFromTextField2_

    on setTextViewFromTextField3_(sender)
        set textField2Value to textField3's stringvalue() as text
        set song2play to textField2Value
            try
                tell application "iTunes"
                    play playlist (song2play)
                end tell
                on error number Err
                    if Err is -1728 then
                        tell application "iRemote"
                            activate
                        display dialog "No Results Found, please try again." with icon 2
                            end tell
                    end if
            end try
    end setTextViewFromTextField3_


    
    on preformclickNext_(aNotification)
        tell application "iTunes" to (next track)
    end preformclickNext_
    
    on preformclickPP_(aNotification)
        tell application "iTunes" to playpause
    end preformclickPP_
    
    on preformclickPrevious_(aNotification)
        tell application "iTunes" to (previous track)
    end preformclickPrevious_
    
    
    on preformclickedson_(aNotification)
        tell application "iTunes"
            if shuffle of playlist "Music" is true then
                tell application "iRemote"
                    activate
                    display dialog "Shuffle is currently on." buttons {"Ok"} with icon 2
                end tell
            end if
        end tell
        tell application "iTunes"
            repeat with i from 1 to (index of last playlist)
                try
                    set shuffle of playlist i to true
                end try
            end repeat
        end tell       
    end preformclickedson_
    
    on preformclickedsoff_(aNotification)
        tell application "iTunes"
            if shuffle of playlist "Music" is false then
                tell application "iRemote"
                    activate
                    display dialog "Shuffle is currently off." buttons {"Ok"} with icon 2
                end tell
            end if
        end tell
        tell application "iTunes"
            repeat with i from 1 to (index of last playlist)
                try
                    set shuffle of playlist i to false
                end try
            end repeat
        end tell
    end preformclickedsoff_
    
    on preformclickIDJO_(aNotification)
        tell application "iTunes"
            if player state is playing then
                try
                    tell application "iTunes"
                        play playlist "iTunes DJ"
                    end tell
                    on error
                    display dialog "Please make sure that iTunes DJ is enabled and that you have the desired playlist selected." buttons {"Ok"} with icon 1 default button "Ok"
                end try

            if name of current playlist is "iTunes DJ" then
                tell application "iRemote" 
                    activate
                    display dialog "iTunes DJ is currently playing." buttons {"OK"} with icon 2 default button 1
                end tell
            end if
        

            else if player state is paused then
        try
			tell application "iTunes"
				play playlist "iTunes DJ"
			end tell
            on error
			display dialog "Please make sure that iTunes DJ is enabled and that you have the desired playlist selected." buttons {"Ok"} with icon 1 default button "Ok"
        end try
        end if
        end tell
    end preformclickIDJO_
    
    on preformclickIDJOff_(aNotification)
        tell application "iTunes"
            if name of current playlist is not "iTunes DJ" then
                tell application "iRemote"
                    activate
                    display dialog "iTunes DJ is currently off" buttons {"Ok"} default button 1 with icon 2
                end tell
            end if
        end tell
        tell application "iTunes"
            if name of current playlist is "iTunes DJ" then
                tell application "iRemote"
                    activate
                    set song to (display dialog "What would you like to hear?" default answer "" buttons {"Play","Cancel"} default button 1 with icon 1)
                    try
                        set song2play to the text returned of song
                        tell application "iTunes"
                            play first item of (search first library playlist for (text returned of song))
                        end tell
                        on error
                        display dialog "No Results Found." buttons {"Ok"} with icon 2 default button "Ok"
                    end try
                    
                end tell
            end if
        end tell
    end preformclickIDJOff_
    
    on preformclickGG_(aNotification)
        -- Register with Growl
        try
            tell application "GrowlHelperApp"
                -- The notification types
                set the allNotificationsList to {"Current Song"}
                set the enabledNotificationList to allNotificationsList
                
                -- Register script with growl
                register as application ¬
                "iRemote" all notifications allNotificationsList ¬
                default notifications enabledNotificationList ¬
                icon of application "iTunes"
            end tell
            
            -- Display the track if iTunes is running
            if appIsRunning("iTunes") then
                tell application "iTunes"
                    if exists name of current track then
                        set aTrack to the current track
                        set aName to the name of aTrack
                        set aArtist to the artist of aTrack
                        -- User artwork as icon if available otherwise default icon (iTunes icon)
                        if (count of artwork of aTrack) ≥ 1 then
                            set anArtwork to data of artwork 1 of aTrack
                            tell application "GrowlHelperApp" to ¬
                            notify with name "Current Song" title aArtist description aName application name "iRemote" pictImage anArtwork
                            else
                            tell application "GrowlHelperApp" to ¬
                            notify with name "Current Song" title aArtist description aName application name "iRemote"
                        end if
                        
                        else
                        tell application "GrowlHelperApp" to ¬
                        notify with name "Current Song" title "Current Song" description "No song playing" application name "iRemote"
                    end if
                    
                end tell
                else
                tell application "GrowlHelperApp" to ¬
                notify with name "Current Song" title "iTunes is not running" description "" application name "iRemote"
            end if
            on error
            tell application "iRemote"
                activate
                display dialog "Please enable Growl to use the Display Song function" buttons {"Enable", "Cancel"} default button 1 with icon 2
                if the button returned of the result is "Enable" then
                    tell application "System Preferences"
                        activate
                        set the current pane to pane id "com.growl.prefpanel"
                        get the name of every anchor of pane id "com.growl.prefpanel"
                    end tell
                    else
                    cancel
                end if
            end tell
        end try
    end preformclickGG_
    -- Check if application is running
    on appIsRunning(appName)
        tell application "System Events" to (name of processes) contains appName
    end appIsRunning
    
    on preformclickSearch_(aNotification)
        
        tell application "iRemote" 
            activate
        end tell
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
end preformclickSearch_
    
    
    
    on preformclickvMute_(aNotification)
        tell application "iTunes"
            set mute to (not mute)
        end tell
        
    end preformclickvMute_
    
    on preformclickvd_(aNotification)
        
        tell application "iTunes"
            if mute is false
            tell application "iTunes"
                if sound volume is 0 then
                    beep
                end if
            end tell
        end if
    end tell
    
    tell application "iTunes"
        if mute is true
        set mute to false
    end if
end tell

tell application "iTunes" to set vol to sound volume
set vol to vol - 10
tell application "iTunes" to set sound volume to vol
end preformclickvd_

    
    
    on preformclickvI_(aNotification)
        tell application "iTunes"
            if mute is false
            tell application "iTunes"
                if sound volume is 100 then
                    beep
                end if
            end tell
        end if
    end tell
    
    tell application "iTunes"
        if mute is true
        set mute to false
    end if
end tell


tell application "iTunes" to set vol to sound volume
set vol to vol + 10
tell application "iTunes" to set sound volume to vol
end preformclickvI_



    

	
	on applicationShouldTerminate_(sender)
		tell application "iTunes"
            if player state is playing then
                tell application "iRemote"
                    activate
                    display dialog "Would you like to pause?" buttons {"Yes", "No"} default button 1 with icon 1
                        if button returned of the result is "Yes" then
                            tell application "iTunes"
                                pause
                            end tell
                        end if
                end tell
            end if
        end tell
                    
		return current application's NSTerminateNow
	end applicationShouldTerminate_
	
end script