#import "FlutterHockeyappPlugin.h"
#import <flutter_hockeyapp/flutter_hockeyapp-Swift.h>

@implementation FlutterHockeyappPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterHockeyappPlugin registerWithRegistrar:registrar];
}
@end
