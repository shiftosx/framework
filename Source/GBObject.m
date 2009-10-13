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

#import "GBObject.h"

//forwarded classes
#import "GBConnection.h"
#import "GBServer.h"


@implementation GBObject

@synthesize connection;
@synthesize server;

- (id) initWithServer:(GBServer *)aServer
{
	self = [super init];
	if (self != nil) {
		self.server = aServer;
		self.connection = aServer.connection;
	}
	return self;
}

- (void)doesNotRecognizeSelector:(SEL)aSelector
{
	NSLog(@"%@ did not implement %@", NSStringFromClass([self class]), NSStringFromSelector(aSelector));
}

- (void)loadNibNamed:(NSString *)name
{
	NSBundle *bundle = [self.server bundle];
	NSMutableArray*      topLevelObjs = [NSMutableArray array];
	NSDictionary*        nameTable = [NSDictionary dictionaryWithObjectsAndKeys:
									  self, NSNibOwner,
									  topLevelObjs, NSNibTopLevelObjects,
									  nil];
	[bundle loadNibFile:name externalNameTable:nameTable withZone:nil];
	[topLevelObjs makeObjectsPerformSelector:@selector(release)];		
}

@end
