
import router from '@ohos.router'

@Entry
@Component
struct Second{
  @State message: string = 'hi there'

  build(){
    Row(){
      Column(){
        Text(this.message)
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
        Button(){
          Text('back')
            .fontSize(25)
            .fontWeight(FontWeight.Bold)
        }
        .type(ButtonType.Capsule)
        .margin({
          top:20
        })
        .backgroundColor('#0d9ffb')
        .width('40%')
        .height('5%')
        .onClick(()=>{
          router.back()
        })
      }
      .width('100%')
    }
    .height('100%')
  }
}