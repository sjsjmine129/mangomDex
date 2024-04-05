//
//  Observable.swift
//  mangomDex
//
//  Created by 엄승주 on 4/5/24.
//

import Foundation

class Observable<T> {

    typealias Listener = (T) -> Void
    
    // 6. value가 변하면 didSet에 의해 변경된, value의 값을 갖고 listner 동작을 실행합니다.
    // 7. 이 코드에선 저장된 동작을 반복 실행 (Timer로 인해 매초 반복)
    var value: T? {
        didSet {
            self.listener?(value!)
        }
    }
    
    init(_ value: T?) {
        self.value = value
    }
       
    // 클로저를 통해 동작을 담아줄 변수를 생성해 줍니다.
    private var listener: (Listener)?
    
    // 메서드(bind)대신 위의 클로저(listener)를 사용해도 되지만, 코드 정리를 위해 bind란 메서드를 만들어 줌
    // 3-2. bind 실행 시, 클로저 안쪽의 동작들을 listner에 저장해 줍니다. (어떠한 동작을 저장)
    // 여기선 TimeLabelText를 업데이트하는 동작(listener)을 저장
    func bind(_ listener: @escaping Listener) {
        listener(value!)    // 생략 가능, 여기선 시작되는 순간부터 초기값을 갖고 동작하기 위해 사용
        self.listener = listener
    }
}
