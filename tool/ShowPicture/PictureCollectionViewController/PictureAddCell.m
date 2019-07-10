

#import "PictureAddCell.h"

@implementation PictureAddCell
{
    UIImageView *addImageView;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
     addImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:addImageView];
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    addImageView.frame = CGRectMake(0, 0, 75, 75);
    addImageView.image = [UIImage imageNamed:@"添加.png"];
    
    
}


@end
