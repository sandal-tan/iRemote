--
--  iRemote_LiteAppDelegate.applescript
--  iRemote Lite
--
--  Created by Ian Baldwin on 7/18/11.
--  Copyright 2011 BaldwinSoft. All rights reserved.
--

script iRemote_LiteAppDelegate
	property parent : class "NSObject"
	
	on applicationWillFinishLaunching_(aNotification)
        
		get (current date) as text
        if result contains Tuesday then
            display dialog "Like iRemote Lite? Support us by rating our app or upgrading." buttons {"Rate", "Upgrade", "Cancel"} default button 1 with icon 1
            if button returned of the result is "Rate" then 
                open location "http://itunes.apple.com/us/app/iremote-lite/id432454004?mt=12"
                else if button returned of the result is "Upgrade" then
                open location "http://itunes.apple.com/us/app/iremote/id434157229?mt=12"
            end if
        end if 
        
        get (current date) as text
        if result contains Friday then
            display dialog "Like iRemote Lite? Support us by rating our app or upgrading." buttons {"Rate", "Upgrade", "Cancel"} default button 1 with icon 1
            if button returned of the result is "Rate" then 
                open location "http://itunes.apple.com/us/app/iremote-lite/id432454004?mt=12"
                else if button returned of the result is "Upgrade" then
                open location "http://itunes.apple.com/us/app/iremote/id434157229?mt=12"
            end if
        end if
        
        try
            tell application "Finder"
                return name of application file id "com.Growl.GrowlHelperApp"
            end tell
            on error
            tell application "iRemote Lite"
                display dialog "It appears that Growl is not installed. If You wish to use the song display function of iRemote than you must download Growl." buttons {"Download", "Cancel"} with icon 2 default button 1
                if the button returned of the result is "Download" then
                    open location "http://www.growl.info"
                    else
                    cancel
                end if
            end tell
        end try 
        
	end applicationWillFinishLaunching_
    
    on clickNext_(aNotification)
        tell application "iTunes"
            next track
        end tell
    end clickNext_
    
    on clickPlayPause_(aNotification)
        tell application "iTunes"
            playpause
        end tell
    end clickPlayPause_
	
    on clickPrevious_(aNotification)
        tell application "iTunes"
            previous track
        end tell
    end clickPrevious_
    
    on perfromUpgrade_(aNotification)
        open location "http://itunes.apple.com/us/app/iremote/id434157229?mt=12"
    end perfromUpgrade_
    
    on preformclickInfo_(aNotification)
        -- Register with Growl
        tell application "GrowlHelperApp"
            -- The notification types
            set the allNotificationsList to {"Current Song"}
            set the enabledNotificationList to allNotificationsList
            
            -- Register script with growl
            register as application ¬
            "iTunes Current Song AppleScript" all notifications allNotificationsList ¬
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
                        notify with name "Current Song" title aArtist description aName application name "iTunes Current Song AppleScript" pictImage anArtwork
                        else
                        tell application "GrowlHelperApp" to ¬
                        notify with name "Current Song" title aArtist description aName application name "iTunes Current Song AppleScript"
                    end if
                    
                    else
                    tell application "GrowlHelperApp" to ¬
                    notify with name "Current Song" title "Current Song" description "No song playing" application name "iTunes Current Song AppleScript"
                end if
                
            end tell
            else
            tell application "GrowlHelperApp" to ¬
            notify with name "Current Song" title "iTunes is not running" description "" application name "iTunes Current Song AppleScript"
        end if
        
end preformclickInfo_
    
    -- Check if application is running
    on appIsRunning(appName)
        tell application "System Events" to (name of processes) contains appName
    end appIsRunning
 
    
    
	on applicationShouldTerminate_(sender)
		tell application "iTunes"
            if player state is playing then
                tell application "iRemote Lite"
                    display dialog "Would you like to pause iTunes?" buttons {"Yes", "No"} default button 1 with icon 1 
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