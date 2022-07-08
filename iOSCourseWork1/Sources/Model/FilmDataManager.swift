//
//  FilmDataManager.swift
//  iOSCourseWork1
//
//  Created by max on 05.04.2022.
//  Copyright © 2022 Ildar Zalyalov. All rights reserved.
//

import Foundation
import UIKit

final class FilmDataManager {
    private let dateFormatter = DateFormatter()

    func createModelsForUser1() -> [FilmData]{
        return [ FilmData(imageName: (UIImage(named: "00")?.jpeg)!, description: "Князь меняется телами с Юлием, и конь берется править Русью. Сиквел о том, как полезно побывать в чужой шкуре", date: dateFormatter.stringToDate(date: "22.02.2022"), rate: 1, pathToVideo: "03"),
                 FilmData(imageName: (UIImage(named: "01")?.jpeg)!, description: "Семьянин и гендиректор в роли младенцев спасают мир. Грандиозный сиквел мультфильма о братьях-спецагентах", date: dateFormatter.stringToDate(date:  "21.02.2022"), rate: 2, pathToVideo: "05"),
                 FilmData(imageName: (UIImage(named: "02")?.jpeg)!, description: "У сотрудника крупного банка всё идёт по накатанной, пока он однажды не выясняет, что окружающий его мир — часть огромной видеоигры, где игроки могут делать всё, что захотят.", date: dateFormatter.stringToDate(date:  "20.02.2022"), rate: 2, pathToVideo: "03"),
                 FilmData(imageName: (UIImage(named: "03")?.jpeg)!, description: "Мастеру боевых искусств Шан-Чи предстоит противостоять призракам из собственного прошлого, по мере того как его втягивают в паутину интриг таинственной организации «Десять колец».", date: dateFormatter.stringToDate(date: "19.02.2022"), rate: 2, pathToVideo: "08"),
                 FilmData(imageName: (UIImage(named: "04")?.jpeg)!, description: "Инопланетянин должен был уничтожить людей, но застрял среди них. Алан Тьюдик в экранизации комиксов Dark Horse", date: dateFormatter.stringToDate(date:  "18.02.2022"), rate: 2, pathToVideo: "02"),
                 FilmData(imageName: (UIImage(named: "05")?.jpeg)!, description: "Принц и сын бунтовщика пытаются занять свое место в жестоком мире. Начало фэнтези-саги по романам Веры Камши", date: dateFormatter.stringToDate(date:  "01.02.2022"), rate: 4, pathToVideo: "00"),
                 FilmData(imageName: (UIImage(named: "06")?.jpeg)!, description: "Семья отправляется в отпуск на тропический остров. Отдохнув всего пару часов на уединенном пляже, они обнаруживают, что повзрослели на несколько лет, а вся жизнь теперь — это один день.", date: dateFormatter.stringToDate(date:  "21.02.2022"), rate: 2, pathToVideo: "07"),
                 FilmData(imageName: (UIImage(named: "07")?.jpeg)!, description: "Атрейдесы прибывают на планету, где им никто не рад. Тимоти Шаламе в фантастическом эпосе Дени Вильнёва", date: dateFormatter.stringToDate(date:  "23.02.2022"), rate: 5, pathToVideo: "04"),
                 FilmData(imageName: (UIImage(named: "08")?.jpeg)!, description: "Матье поручено расследование странной авиакатастрофы с участием новейшего лайнера. Однако безо всяких причин, в один момент, власти снимают задание.", date: dateFormatter.stringToDate(date:  "23.02.2022"), rate: 2, pathToVideo: "09"),
                 FilmData(imageName: (UIImage(named: "09")?.jpeg)!, description: "Подросток мстит гуманоидам-людоедам за убийство матери. Культовый аниме-сериал по постапокалиптической манге", date: dateFormatter.stringToDate(date:  "24.02.2022"), rate: 2, pathToVideo: "01")
        ]
    }
    
    func createModelsForUser2() -> [FilmData]{
        return [ FilmData(imageName: (UIImage(named: "00")?.jpeg)!, description: "Конь берется править Русью. Сиквел о том, как полезно побывать в чужой шкуре", date: dateFormatter.stringToDate(date: "22.02.2022"), rate: 1, pathToVideo: "03"),
                 FilmData(imageName: (UIImage(named: "01")?.jpeg)!, description: "Семьянин и гендиректор в роли младенцев спасают мир. Грандиозный сиквел мультфильма о братьях-спецагентах", date: dateFormatter.stringToDate(date:  "21.02.2022"), rate: 2, pathToVideo: "05"),
                 FilmData(imageName: (UIImage(named: "02")?.jpeg)!, description: "У сотрудника крупного банка всё идёт по накатанной, пока он однажды не выясняет, что окружающий его мир — часть огромной видеоигры, где игроки могут делать всё, что захотят.", date: dateFormatter.stringToDate(date:  "20.02.2022"), rate: 2, pathToVideo: "03"),
                 FilmData(imageName: (UIImage(named: "03")?.jpeg)!, description: "Мастеру боевых искусств Шан-Чи предстоит противостоять призракам из собственного прошлого, по мере того как его втягивают в паутину интриг таинственной организации «Десять колец».", date: dateFormatter.stringToDate(date: "19.02.2022"), rate: 2, pathToVideo: "08"),
                 FilmData(imageName: (UIImage(named: "04")?.jpeg)!, description: "Инопланетянин должен был уничтожить людей, но застрял среди них. Алан Тьюдик в экранизации комиксов Dark Horse", date: dateFormatter.stringToDate(date:  "18.02.2022"), rate: 2, pathToVideo: "02"),
                 FilmData(imageName: (UIImage(named: "05")?.jpeg)!, description: "Принц и сын бунтовщика пытаются занять свое место в жестоком мире. Начало фэнтези-саги по романам Веры Камши", date: dateFormatter.stringToDate(date:  "01.02.2022"), rate: 4, pathToVideo: "00"),
                 FilmData(imageName: (UIImage(named: "06")?.jpeg)!, description: "Семья отправляется в отпуск на тропический остров. Отдохнув всего пару часов на уединенном пляже, они обнаруживают, что повзрослели на несколько лет, а вся жизнь теперь — это один день.", date: dateFormatter.stringToDate(date:  "21.02.2022"), rate: 2, pathToVideo: "07"),
                 FilmData(imageName: (UIImage(named: "07")?.jpeg)!, description: "Атрейдесы прибывают на планету, где им никто не рад. Тимоти Шаламе в фантастическом эпосе Дени Вильнёва", date: dateFormatter.stringToDate(date:  "23.02.2022"), rate: 5, pathToVideo: "04"),
                 FilmData(imageName: (UIImage(named: "08")?.jpeg)!, description: "Матье поручено расследование странной авиакатастрофы с участием новейшего лайнера. Однако безо всяких причин, в один момент, власти снимают задание.", date: dateFormatter.stringToDate(date:  "23.02.2022"), rate: 2, pathToVideo: "09"),
                 FilmData(imageName: (UIImage(named: "09")?.jpeg)!, description: "Подросток мстит гуманоидам-людоедам за убийство матери. Культовый аниме-сериал по постапокалиптической манге", date: dateFormatter.stringToDate(date:  "24.02.2022"), rate: 2, pathToVideo: "01")
        ]
    }
    
    func obtainListOfFilms() -> [[String]] {
        return [
            ["Списки лучших фильмов",
             "Топ-100 популярных фильмов",
             "Топ-250 лучших фильмов",
             "Самые ожидаемые фильмы",
             "Цифровые релизы"
            ],[
            "Самые кассовые фильмы",
            "Прошлый уик-энд"]
        ]
    }
}
