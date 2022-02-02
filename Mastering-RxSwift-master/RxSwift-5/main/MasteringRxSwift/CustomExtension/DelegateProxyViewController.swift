//
//  Copyright (c) 2019 KxCoding <kky0317@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit
import CoreLocation
import RxSwift
import RxCocoa
import MapKit

class DelegateProxyViewController: UIViewController {
   
   let bag = DisposeBag()
   
   @IBOutlet weak var mapView: MKMapView!
   
   let locationManager = CLLocationManager()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
       locationManager.requestWhenInUseAuthorization()
       locationManager.startUpdatingLocation()
       
       locationManager.rx.didUpdateLocations
           .subscribe(onNext: { locations in
               print(locations)
           })
           .disposed(by: bag)
       
       locationManager.rx.didUpdateLocations
           .map { $0[0] }
           .bind(to: mapView.rx.center)
           .disposed(by: bag)
      
   }
}


extension Reactive where Base: MKMapView {
   public var center: Binder<CLLocation> {
      return Binder(self.base) { mapView, location in
         let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
         self.base.setRegion(region, animated: true)
      }
   }
}

/// 1단계
extension CLLocationManager: HasDelegate {
    public typealias Delegate = CLLocationManagerDelegate
}

class RxCLLocationManagerDelegateProxy: DelegateProxy<CLLocationManager, CLLocationManagerDelegate>, DelegateProxyType, CLLocationManagerDelegate {
    
    weak private(set) var locationManager: CLLocationManager?
    
    init(locationManager: CLLocationManager) {
        self.locationManager = locationManager
        super.init(parentObject: locationManager, delegateProxy: RxCLLocationManagerDelegateProxy.self)
    }
    
    static func registerKnownImplementations() {
        self.register {
            RxCLLocationManagerDelegateProxy(locationManager: $0)
        }
    }
}

extension Reactive where Base: CLLocationManager {
    
    var delegate: DelegateProxy<CLLocationManager, CLLocationManagerDelegate> {
        /// 생성자를 직접 사용하지 않는다
        /// 인스턴스가 두개 이상 생성되는 문제가 있다
        /// 이렇게 되면 예상과 다르게 동작한다
        return RxCLLocationManagerDelegateProxy.proxy(for: base)
    }
    
    var didUpdateLocations: Observable<[CLLocation]> {
        return delegate.methodInvoked(#selector(CLLocationManagerDelegate.locationManager(_:didUpdateLocations:)))
            .map {
                return $0[1] as! [CLLocation]
            }
    }
    
}

