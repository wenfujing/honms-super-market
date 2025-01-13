
import Animator, { AnimatorResult } from '@ohos.animator';
import router from '@ohos.router';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World'


  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
        Button(){
          Text('next').fontSize(30).fontWeight(FontWeight.Bold)
        }.type(ButtonType.Capsule)
        .margin({
          top:20
        })
        .backgroundColor('#0d9ffb')
        .width('40%')
        .height('5%')
        .onClick(()=>{
          router
            .pushUrl({url:'pages/Second'})
        })
      }
      .width('100%')
    }
    .height('100%')
  }
}



