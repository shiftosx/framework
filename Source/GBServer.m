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

#import "GBServer.h"

//forwarded classes
#import "GBEditor.h"
#import "GBResult.h"
#import "GBSchema.h"


@implementation GBServer

@synthesize preferences;

@synthesize connected;

@synthesize schemas;

+ (NSString *)type
{
	NSLog(@"You forgot to specify a type for this gearbox");
	return @"Unspecified Type";
}

+ (NSImage *)icon
{
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}

- (id) init
{
	self = [super init];
	if (self != nil) {
		self.connected = NO;
	}
	return self;
}

- (void) dealloc
{
	[super dealloc];
}


- (NSBundle *)bundle
{
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}

- (GBEditor *)editor
{
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}

- (id)createConnection:(NSDictionary *)dictionary
{
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}


- (void)connect:(GBConnection *)aConnection
{
	self.connection = [aConnection retain];
	self.connected = YES;
}

- (void)disconnect
{
	self.connection = nil;
	self.connected = NO;
}


- (NSArray *)listSchemas:(NSString *)filter
{
	return [self filterArray:self.schemas withFilter:filter];
}

- (void)selectSchema:(GBSchema *)schema
{
	[self doesNotRecognizeSelector:_cmd];
}

- (GBResultSet *)query:(NSString *)query
{
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}

- (NSString *)lastErrorMessage
{
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}

- (NSArray *)filterArray:(NSArray *)array withFilter:(NSString *)filter
{
	if (filter)
		return [array filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@", filter]];
	else
		return array;	
}

- (void)postNotification:(NSString *)notification withInfo:(NSDictionary *)info
{
	[[NSNotificationCenter defaultCenter] postNotificationName:notification object:self userInfo:info];
}

@end
