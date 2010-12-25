//
//  MLoader.h
//  SeatbeltToggler
//
//  Created by Thomas Cool on 10/22/10.
//  Copyright 2010 tomcool.org. All rights reserved.
//
#import <SMFramework/SMFramework.h>
#import <Foundation/Foundation.h>




@interface SeatbeltToggler : NSObject<SMFSettingPreferences> {
    
}
+(NSString *)displayName;
-(NSString *)displayName;
+(BRMenuController *)settingsController;
@end

@interface SeatbeltTogglerController : SMFMediaMenuController 
{

}
@end