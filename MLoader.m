//
//  MLoader.m
//  SeatbeltToggler
//
//  Created by Thomas Cool on 10/22/10.
//  Copyright 2010 tomcool.org. All rights reserved.
//
#import "MLoader.h"
#import <BackRow/BackRow.h>
#import "BackRowExtras.h"





@implementation SeatbeltToggler
+(NSString *)displayName
{
    return BRLocalizedString(@"Seatbelt Toggler",@"Seatbelt Toggler");
}
-(NSString *)displayName
{
    return BRLocalizedString(@"Seatbelt Toggler",@"Seatbelt Toggler");
}
-(NSString *)summary
{
    return BRLocalizedString(@"Activate and Deactivate Seatbelt",@"Activate and Deactivate Seatbelt");
}
-(BRImage *)art
{
    return [[SMFThemeInfo sharedTheme] seatbeltImage];
}
+(BRMenuController *)settingsController
{
    return [[[SeatbeltTogglerController alloc]init] autorelease];
}
@end

enum {
    kSeatbeltDisplay=0,
    kSeatbeltBuckle,
    kSeatbeltUnbuckle,
    kSeatbeltRestartLowtide,
    kSeatbeltOptions
};
@implementation SeatbeltTogglerController
-(void)reload
{
    [[self list]reload];
}
-(id)previewControlForItem:(long)item
{
    SMFBaseAsset *asset = [[SMFBaseAsset alloc] init];
    switch (item) {
        case kSeatbeltBuckle:
            [asset setTitle:BRLocalizedString(@"Buckle Seatbelt",@"Buckle Seatbelt")];
            [asset setSummary:BRLocalizedString(@"Enables seabelt removing functionality but enabling iTunes",
                                                @"Enables seabelt removing functionality but enabling iTunes")];
            break;
        case kSeatbeltUnbuckle:
            [asset setTitle:BRLocalizedString(@"Unbuckle Seatbelt",@"Unbuckle Seatbelt")];
            [asset setSummary:BRLocalizedString(@"Disables seabelt which disables iTunes and builtin media but allows extra functionality to third party",
                                                @"Disables seabelt which disables iTunes and builtin media but allows extra functionality to third party")];
            break;
        case kSeatbeltRestartLowtide:
            [asset setTitle:@"Restart Lowtide"];
            break;
        default:
            break;
    }
    [asset setCoverArt:[[SMFThemeInfo sharedTheme]seatbeltImage]];
    [asset setCustomKeys:[NSArray arrayWithObject:BRLocalizedString(@"NOTE",@"NOTE")] 
              forObjects:[NSArray arrayWithObject:BRLocalizedString(@"Restart Lowtide to take effect",
                                                                    @"Restart Lowtide to take effect")]];
    SMFMediaPreview *p = [[SMFMediaPreview alloc] init];
    [p setShowsMetadataImmediately:YES];
    [p setAsset:asset];
    [asset release];
    return [p autorelease];
}
- (long)itemCount							
{ 
    return kSeatbeltOptions;
}
- (id)itemForRow:(long)row					
{ 
    switch (row) {
        case kSeatbeltDisplay:
        {
            SMFMenuItem *it = [SMFMenuItem menuItem];
            [it setTitle:[NSString stringWithFormat:BRLocalizedString(@"Seatbelt is %@",@"Seatbelt is %@"),
                          ([[SMFCommonTools sharedInstance] syscallSeatbeltEnabled]!=1?BRLocalizedString(@"Disabled",@"Disabled"):BRLocalizedString(@"Enabled",@"Enabled")),
                          nil]];
            return it;
            break;
        }
        case kSeatbeltBuckle:
        {
            SMFMenuItem *it = [SMFMenuItem menuItem];
            [it setTitle:BRLocalizedString(@"Buckle Seatbelt",@"Buckle Seatbelt")];
            if ([[SMFCommonTools sharedInstance] syscallSeatbeltEnabled]==1)
                [it setDimmed:YES];
            return it;
            break;
        }
        case kSeatbeltUnbuckle:
        {
            SMFMenuItem *it = [SMFMenuItem menuItem];
            [it setTitle:BRLocalizedString(@"Unbuckle Seatbelt",@"Unbuckle Seatbelt")];
            if ([[SMFCommonTools sharedInstance] syscallSeatbeltEnabled]!=1)
                [it setDimmed:YES];
            return it;
            break;
        }
        case kSeatbeltRestartLowtide:
        {
            SMFMenuItem *it = [SMFMenuItem menuItem];
            [it setTitle:BRLocalizedString(@"Restart Lowtide",@"Restart Lowtide")];
            return it;
            break;
        }
            
        default:
            break;
    }
    return nil;
}

- (id)titleForRow:(long)row					
{ 
    
    return [[self itemForRow:row] text];
}


+(NSString *)rootMenuLabel
{
    return @"org.tomcool.SeabeltToggler";
}
-(id)init
{
    if ((self = [super init])!=nil) {
        [self setListTitle:BRLocalizedString(@"Seatbelt Toggler",@"Seatbelt Toggler")];
        [[self list]addDividerAtIndex:1 withLabel:@""];
        [[self list]addDividerAtIndex:3 withLabel:@""];
        
    }
    return self;
}
-(void)itemSelected:(long)selected
{
    switch (selected) {
        case kSeatbeltBuckle:
            if ([[SMFCommonTools sharedInstance] syscallSeatbeltEnabled]!=1) {
                [[SMFCommonTools sharedInstance] enableSeatbelt];
            }
            break;
        case kSeatbeltUnbuckle:
            if ([[SMFCommonTools sharedInstance] syscallSeatbeltEnabled]!=0) {
                [[SMFCommonTools sharedInstance] disableSeatbelt];
            }
            break;
        case kSeatbeltRestartLowtide:
            [[SMFCommonTools sharedInstance] restartLowtide];
            break;
        default:
            break;
    }
    [[self list] reload];
}
@end