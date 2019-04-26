//
//  DataModel.swift
//  Guardabosques
//
//  Created by JJ Santos on 4/26/19.
//  Copyright © 2019 JJ Santos. All rights reserved.
//

import Foundation


class Report {
    
    var category = ""
    var messageBody = ""
    var sender = ""
    var senderLocation = ""
    
}

let fauna: [String] = [
    "Ajolote",
    "Perrito de la pradera",
    "Jaguar",
    "Ocelote",
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
