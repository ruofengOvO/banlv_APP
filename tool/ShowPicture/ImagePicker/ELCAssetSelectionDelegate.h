
#import <Foundation/Foundation.h>

@class ELCAsset;

@protocol ELCAssetSelectionDelegate <NSObject>

- (void)selectedAssets:(NSArray *)assets;
- (BOOL)shouldSelectAsset:(ELCAsset *)asset previousCount:(NSUInteger)previousCount;
- (BOOL)shouldDeselectAsset:(ELCAsset *)asset previousCount:(NSUInteger)previousCount;

@end
