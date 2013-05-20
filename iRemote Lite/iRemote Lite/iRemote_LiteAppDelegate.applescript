--
--  iRemote_LiteAppDelegate.applescript
--  iRemote Lite
--
--  Created by Ian Baldwin on 4/25/11.
--  Copyright 2011 BaldwinSoft. All rights reserved.
--

script iRemote_LiteAppDelegate
	property parent : class "NSObject"
    property button1 : missing value
	
	on applicationWillFinishLaunching_(aNotification)
        
        tell application "iTunes"
            if player state is playing then
                set title of button1 to "Pause"
            else if player state is paused then 
                set title of button1 to "Play"
            else if player state is stopped then 
                set title of button1 to "Play"
            end if
        end tell
        
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
    
    tell application "System Events" to (name of processes) contains "iRemote Lite"
    if result is true then
    repeat
        tell application "iTunes"
            if player state is playing then
                set title of button1 to "Pause"
                else if player state is paused then 
                set title of button1 to "Play"
                else if player state is stopped then 
                set title of button1 to "Play"
            end if
        end tell
        end repeat
    end if
        
    
    on preformclickNext_(aNotification)
        tell application "iTunes" to (next track)
    end preformclickNext_
	
    on preformclickPP_(aNotification)
        tell application "iTunes"
            playpause
        if player state is playing then
            set title of button1 to "Pause"
            else if player state is paused then 
            set title of button1 to "Play"
            else if player state is stopped then 
            set title of button1 to "Play"
        end if
        end tell
    end preformclickPP_
    
    on preformclickPrevious_(aNotification)
        tell application "iTunes" to (previous track)
    end preformclickPrevious_
    
	on applicationShouldTerminate_(sender)
		-- Insert code here to do any housekeeping before your application quits 
		return current application's NSTerminateNow
	end applicationShouldTerminate_
    
    on preformclickGG_(aNotification)
        -- Register with Growl
        try
            tell application "GrowlHelperApp"
                -- The notification types
                set the allNotificationsList to {"Current Song"}
                set the enabledNotificationList to allNotificationsList
                
                -- Register script with growl
                register as application ¬
                "iRemote Lite" all notifications allNotificationsList ¬
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
                            notify with name "Current Song" title aArtist description aName application name "iRemote Lite" pictImage anArtwork
                            else
                            tell application "GrowlHelperApp" to ¬
                            notify with name "Current Song" title aArtist description aName application name "iRemote Lite"
                        end if
                        
                        else
                        tell application "GrowlHelperApp" to ¬
                        notify with name "Current Song" title "Current Song" description "No song playing" application name "iRemote Lite"
                    end if
                    
                end tell
                else
                tell application "GrowlHelperApp" to ¬
                notify with name "Current Song" title "iTunes is not running" description "" application name "iRemote Lite"
            end if
            on error
            tell application "iRemote Lite"
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
    
    on preformclickUpgrade_(aNotification)
        open location "http://itunes.apple.com/us/app/iremote/id434157229?mt=12"
    end preformclickUpgrade_

	
end script