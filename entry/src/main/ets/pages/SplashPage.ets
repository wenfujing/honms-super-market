@Entry
@Component
struct SplashPage {
  @State message: string = 'Hello World'

  build() {
    Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center }) {
      Column() {
        Image($r('app.media.ic_eshop'))
          .width(new BreakpointT)
      }
    }
  }
}