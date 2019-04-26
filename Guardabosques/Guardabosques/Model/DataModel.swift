//
//  DataModel.swift
//  Guardabosques
//
//  Created by JJ Santos on 4/26/19.
//  Copyright © 2019 JJ Santos. All rights reserved.
//

import Foundation


class Report {
    
    var title = ""
    var message = ""
    var username = ""
    var location = ""
    
}

let locations: [String] = [

    "Parque Ecologico de Xochimilco",
    "Reserva de la Biosfera de Janos",
    "Reserva de la Biosfera de El Triunfo",
    "Planicies del Pacifico",
    "Sierra Madre Occidental",
    "Golfo de California",
    "Reserva de la Biosfera El Cielo",
    "Altiplano Mexicano",
    "Sierra Madre Oriental",
    "Selvas del Sur",
    "Selvas del Sureste",
    "Parque Nacional Popocatepetl",
    "Reserva de la Biosfera El Vizcaino",
    "Parque Nacional El Nevado de Colima",
    "Zona de Refugio El Jabali",
    "Sierra de Juarez",
    "Jardin Botanico Instituto de Ecologia",
    "Cactaceas de Guanajuato",
    "Otro"
]


let fauna: [String] = [
    "Ajolote",
    "Perrito de la pradera",
    "Jaguar",
    "Ocelote",
    "Quetzal",
    "Vaquita marina",
    "Manati de las Antillas",
    "Lobo gris mexicano",
    "Tapir centroamericano",
    "Teporingo",
    "Tortuga caguama",
    "Ardilla de piedra",
    "Rata canguro",
    "Ballena gris",
    "Otro"
]

let flora: [String] = [
    "Barril de oro",
    "Tasajillo de Colima",
    "Acritodon",
    "Ceratozomia",
    "Palma de Guadalupe",
    "Yucca",
    "Cactus Estrella",
    "Otro"
]

let weather: [String] = [
    "Temperatura",
    "Humedad",
    "Altitud"
]

let alerts: [String] = [
    "Sismos",
    "Incendios",
    "Volcanes",
    "Tormentas",
    "Inundaciones",
    "Otro"
]
