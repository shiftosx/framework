/* 
 * Shift is the legal property of its developers, whose names are listed in the copyright file included
 * with this source distribution.
 * 
 * This program is free software; you can redistribute it and/or modify it under the terms of the GNU
 * General Public License as published by the Free Software Foundation; either version 3 of the License,
 * or (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even
 * the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General
 * Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License along with this program; if not,
 * write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA 
 * or see <http://www.gnu.org/licenses/>.
 */

#import <Cocoa/Cocoa.h>
#import "GBObject.h"
#import "GBServer.h"

#define GBNotificationConnected           @"GBNotificationConnected"
#define GBNotificationConnectionFailed    @"GBNotificationConnectionFailed"
#define GBNotificationInvalidQuery        @"GBNotificationInvalidQuery"


//forwarded classes
@class GBConnection, GBEditor, GBPreferences, GBResultSet, GBSchema;

@interface GBServer : GBObject {
	GBEditor *editor;
	GBPreferences *preferences;
	
	BOOL connected;
	
	NSArray *schemas;
}

@property (readonly) NSBundle *bundle;
@property (readonly) GBEditor *editor;
@property (readonly) GBPreferences *preferences;

@property (getter=isConnected) BOOL connected;

@property (readonly) NSArray *schemas;

+ (NSString *)type;
+ (NSImage *)icon;

- (id)createConnection:(NSDictionary *)dictionary;

- (void)connect:(GBConnection *)aConnection;
- (void)disconnect;

- (NSArray *)listSchemas:(NSString *)filter;
- (void)selectSchema:(GBSchema *)schema;

- (GBResultSet *)query:(NSString *)query;
- (NSString *)lastErrorMessage;

- (NSArray *)filterArray:(NSArray *)array withFilter:(NSString *)filter;

- (void)postNotification:(NSString *)notification withInfo:(NSDictionary *)info;

@end
