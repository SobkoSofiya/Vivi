//
//  ContentView.swift
//  Vivi
//
//  Created by Sofi on 02.03.2021.
//

import SwiftUI
import YouTubePlayer
import AVKit
struct ContentView: View {
    @ObservedObject var model = ViewModel()
    
    var body: some View {
        ZStack{
            Vid(urlString: "http://gym.areas.su/up/video.mp4")
        }.onAppear(perform: {
            model.GetVideo()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct VideoView:View {
    @Binding var mo :[Model]
    var body: some View{
        ScrollView(.horizontal){
            HStack(spacing:410){
                ForEach(mo, id:\.self){ i in
                    VStack{
                        Video(urlSring: "\(i.url)").frame(width: 400, height: 400, alignment: .center)
                        Text("fooooooooo")
                    }
                    
                }
            }
            
        }
    }
}



struct Video:UIViewControllerRepresentable {
    @State var urlSring:String
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<Video>) {
        
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<Video>) ->  UIViewController {
        let controller = UIViewController()
        let url = URL(string: urlSring)
        let Video1 = YouTubePlayerView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
        Video1.loadVideoURL(url!)
        controller.view.addSubview(Video1)
        return controller
    }
    
}


struct Vid:UIViewControllerRepresentable {
    @State var pla = AVPlayerViewController()
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: UIViewControllerRepresentableContext<Vid>) {
//        uiViewController.player?.currentTime()
//        DispatchQueue.global(qos: .background).async {
////
//            while true{
//                let screenWidth :CGFloat = 333
//                
//                let currenttime = uiViewController.player.currentTime/uiViewController.player.duration
//                
////                                        *2.5/15*100
//                
//                let timeForLabel = CGFloat(currenttime) * screenWidth
//                
//                
//                self.time = timeForLabel
//               
//                
//            }
//            
//            
//        }
    }
    
    @State var urlString:String
    func makeUIViewController(context: UIViewControllerRepresentableContext<Vid>) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        let url = URL(string: urlString)
        let Video1 = AVPlayer(url: url!)
        controller.player = Video1
        return controller
    }
}
