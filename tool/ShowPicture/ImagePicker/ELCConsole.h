

#import <Foundation/Foundation.h>

@interface ELCConsole : NSObject
{
    NSMutableArray *myIndex;
}
@property (nonatomic,assign) BOOL onOrder;
+ (ELCConsole *)mainConsole;
- (void)addIndex:(int)index;
- (void)removeIndex:(int)index;
- (int)currIndex;
- (int)numOfSelectedElements;
- (void)removeAllIndex;
@end
