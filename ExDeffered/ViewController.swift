//
//  ViewController.swift
//  ExDeffered
//
//  Created by 김종권 on 2023/01/11.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    var someProperty: Int?
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Observable
            .concat(
                firstObservable(),
//                secondObservable()
                .deferred { [weak self] in self?.secondObservable() ?? .empty() }
            )
            .subscribe()
            .disposed(by: disposeBag)
        
    }
    
    private func firstObservable() -> Observable<Void> {
        .create { [weak self] observer in
            print("first")
            self?.someProperty = 1
            observer.onNext(())
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
//    private func secondObservable() -> Observable<Void> {
//        .create { [weak self] observer in
//            print("second")
//            print(self?.someProperty!)
//            observer.onNext(())
//            observer.onCompleted()
//            return Disposables.create()
//        }
//    }
    
    private func secondObservable() -> Observable<Void> {
        print("second")
        print(someProperty!)
        return .just(())
    }
}
