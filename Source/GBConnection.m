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

#import "GBConnection.h"
#import "KeyChain.h"

//private method

@interface GBConnection (private)

- (NSArray *)__gbRequiredKeys;

@end


@implementation GBConnection (private)

- (NSArray *)__gbRequiredKeys
{
	return [NSArray arrayWithObjects:@"name", @"uuid", @"type", nil];
}

@end

//public implementation
@implementation GBConnection

@synthesize name;
@synthesize uuid;
@synthesize type;

- (id) init
{
	self = [super init];
	if (self != nil) {
		keychain = [[[KeyChain alloc] init] retain];
	}
	return self;
}

- (void) dealloc
{
	[keychain release];
	[super dealloc];
}


- (NSString *)uuid
{
	if (uuid == nil)
		self.uuid = [[NSProcessInfo processInfo] globallyUniqueString];
	
	return uuid;
}

- (NSString *)password
{
	return [keychain getPasswordForConnection:self];
}

- (void)setPassword:(NSString *)aPassword
{
	//save the password to the keychain
	if (aPassword == nil || [aPassword isEqualToString:@""])
		[keychain deletePasswordForConnection:self];
	else if (![[keychain getPasswordForConnection:self] isEqualToString:aPassword])
		[keychain setPasswordForConnection:self to:aPassword];
}

- (void)connectionWillBeDeleted
{
	//make sure the password is removed from the keychain
	[self setPassword:nil];
}

- (NSArray *)gbKeys
{
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}

- (NSDictionary*)dictionaryRepresentation
{
	NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];

	for (NSString *key in [[self __gbRequiredKeys] arrayByAddingObjectsFromArray:[self gbKeys]]) {
		[dictionary setObject:[self valueForKey:key] forKey:key];
	}
	return dictionary;
}

- (id)initWithDictionary:(NSDictionary*)dictionary
{
	self = [self init];
	if (self) {
		for (NSString *key in [[self __gbRequiredKeys] arrayByAddingObjectsFromArray:[self gbKeys]]) {
			[self setValue:[dictionary objectForKey:key] forKey:key];
		}
	}
	return self;
}
@end