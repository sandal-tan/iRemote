//
//  main.m
//  iRemote
//
//  Created by Ian Baldwin on 6/6/11.
//  Copyright 2011 BaldwinSoft. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import <AppleScriptObjC/AppleScriptObjC.h>

int main(int argc, char *argv[])
{
    [[NSBundle mainBundle] loadAppleScriptObjectiveCScripts];
    return NSApplicationMain(argc, (const char **)argv);
}
