--[[
    MAGOz City Assist 1.0
    Autor técnico: Mago Scripts

    La personalización del menú y los servicios se realiza desde este archivo.
    La identidad, el Discord y el estado mostrados en la consola son internos.
    El recurso no necesita dependencias obligatorias.
]]

Config = {}

Config.Debug = false
Config.Locale = 'es'
Config.Framework = 'auto'
Config.AdminPermission = 'magoz_cityassist.admin'

Config.CustomFramework = {
    enabled = false,
    bridgeFile = 'bridge/custom.lua'
}

Config.Compatibility = {
    useStandaloneFallback = true,
    detectFrameworkAutomatically = true,
    detectIntegrationsAutomatically = true,

    notification = 'auto',
    target = 'auto',
    inventory = 'auto',
    medical = 'auto',
    dispatch = 'auto',
    phone = 'auto',
    fuel = 'auto',
    vehicleKeys = 'auto',
    menu = 'auto',
    garage = 'auto',
    banking = 'auto'
}

Config.Branding = {
    resourceName = 'MAGOz City Assist',
    technicalName = 'magoz_cityassist',

    companyName = 'MAGOz Arcane',
    developerName = 'MAGOz',
    technicalAuthor = 'Mago Scripts',

    edition = 'Community Edition',
    version = '1.0',

    discordName = 'Big Customs',
    discordInvite = 'https://discord.gg/7uzhfErNhN',

    footerText = 'Developed by MAGOz Arcane'
}

Config.Promotion = {
    enabled = true,
    showInMainMenu = true,
    showOnFirstJoin = false,
    sendMessagesToChat = false,
    allowCopyDiscord = true,

    title = 'Información y soporte',
    companyText = 'Desarrollado por MAGOz Arcane',
    communityText = 'Comunidad y soporte: Big Customs',
    discordInvite = 'https://discord.gg/7uzhfErNhN'
}

Config.Commands = {
    main = {
        enabled = true,
        command = 'assist',
        aliases = { 'cityassist', 'ayuda' }
    },

    taxi = {
        enabled = true,
        command = 'taxi',
        aliases = { 'taxinpc' }
    },

    mechanic = {
        enabled = true,
        command = 'meca',
        aliases = { 'mechanic', 'reparar' }
    },

    ambulance = {
        enabled = true,
        command = 'ems',
        aliases = { 'ambulancia', 'medico' }
    },

    cancel = {
        enabled = true,
        command = 'assistcancel',
        aliases = { 'cancelassist', 'cancelarservicio' }
    },

    admin = {
        enabled = true,
        command = 'assistadmin',
        aliases = { 'cityassistadmin' }
    },

    moneyDiagnostic = {
        enabled = true,
        command = 'assistmoney',
        aliases = { 'assistdinero' }
    },

    status = {
        enabled = true,
        command = 'assiststatus',
        aliases = { 'assistestado', 'estadocityassist' }
    }
}

Config.Theme = {
    preset = 'magoz_arcane',

    colors = {
        primary = '#7C3AED',
        secondary = '#A855F7',
        accent = '#22D3EE',

        background = '#0F0F17',
        surface = '#181826',
        surfaceLight = '#24243A',

        text = '#FFFFFF',
        textMuted = '#B4B4C7',

        success = '#22C55E',
        warning = '#F59E0B',
        error = '#EF4444',
        information = '#3B82F6',

        border = '#35354D',
        overlay = '#000000E6'
    }
}

-- Todas las rutas deben ser locales, comenzar con "web/" y usar un formato permitido.
Config.Logos = {
    enabled = true,

    mainLogo = 'web/assets/logos/magoz-city-assist.png',
    headerLogo = 'web/assets/logos/magoz-city-assist.png',
    companyLogo = 'web/assets/logos/magoz-arcane.png',
    serverLogo = 'web/assets/logos/server-logo.png',
    communityLogo = 'web/assets/logos/community-logo.png',
    notificationIcon = 'web/assets/icons/notification-icon.png',
    promotionImage = 'web/assets/logos/promotion-image.png',
    backgroundImage = 'web/assets/backgrounds/magoz-city-night.png',

    fallbackLogo = 'web/assets/logos/magoz-city-assist.png',

    showMainLogo = true,
    showHeaderLogo = false,
    showCompanyLogo = true,
    showServerLogo = false,
    showCommunityLogo = false,
    showPromotionImage = false,
    showBackgroundImage = true,

    allowCustomLogos = true,
    allowLogoDisable = true
}

Config.LogoStyle = {
    mainLogo = {
        width = 180,
        maxHeight = 90,
        opacity = 1.0,
        position = 'center'
    },

    headerLogo = {
        width = 56,
        maxHeight = 56,
        opacity = 1.0,
        position = 'top-left'
    },

    companyLogo = {
        width = 88,
        maxHeight = 60,
        opacity = 0.85,
        position = 'bottom-left'
    },

    serverLogo = {
        width = 90,
        maxHeight = 90,
        opacity = 1.0,
        position = 'top-right'
    },

    communityLogo = {
        width = 90,
        maxHeight = 90,
        opacity = 1.0,
        position = 'bottom-right'
    },

    promotionImage = {
        width = 120,
        maxHeight = 70,
        opacity = 0.9,
        position = 'bottom-center'
    }
}

Config.Text = {
    menuTitle = 'Asistencia de la ciudad',
    menuSubtitle = 'Servicios NPC cuando los equipos de la ciudad no están disponibles.',
    activeService = 'Ya tienes un servicio activo.',
    serviceUnavailable = 'Este servicio no está disponible.',
    workersAvailable = 'Hay trabajadores en servicio. Contacta primero con el equipo de la ciudad.',
    insufficientFunds = 'No tienes dinero suficiente.',
    requestAccepted = 'Solicitud aceptada. La unidad va en camino.',
    requestFailed = 'No fue posible iniciar el servicio.',
    serviceCompleted = 'Servicio completado.',
    serviceCancelled = 'Servicio cancelado.',
    refundIssued = 'El servicio falló y el cobro fue devuelto.',
    waitForVehicle = 'La unidad está en camino. Espera en una zona accesible.',
    enterTaxi = 'El taxi llegó. Acércate para subir al asiento de pasajero.',
    passengerSeatOnly = 'Este taxi es un servicio NPC. Sube como pasajero.',
    patientRevived = 'El paramédico te reanimó.',
    patientHealed = 'El paramédico curó tus heridas.',
    waypointRequired = 'Marca un destino en el mapa antes de solicitar este servicio.',
    vehicleRequired = 'Debes estar dentro o cerca de un vehículo.',
    adminDenied = 'No tienes permiso para abrir el diagnóstico.',
    copyDiscord = 'Copiar Discord',
    close = 'Cerrar',
    cancel = 'Cancelar servicio',
    price = 'Precio',
    available = 'Disponible',
    diagnosticTitle = 'Diagnóstico de compatibilidad',
    statusTitle = 'Estado de servicios',
    statusSubtitle = 'Consulta si cada servicio NPC está disponible en este momento.',
    statusAvailable = 'Disponible',
    statusUnavailable = 'No disponible'
}

Config.Services = {
    enabled = true,
    allowFreeStandalone = true,
    refundOnFailure = true,
    fallbackAccounts = { 'bank' },
    cooldownSeconds = 90,
    responseTimeoutSeconds = 600,
    arrivalTimeoutSeconds = 100,
    interactionTimeoutSeconds = 75,
    modelLoadTimeoutSeconds = 10,

    taxi = {
        enabled = true,
        label = 'Taxi',
        description = 'Transporte hasta el destino marcado en el mapa.',
        icon = '🚕',
        price = 250,
        account = 'cash',
        jobs = { 'taxi' },
        blockWhenOnDutyAtLeast = 1,
        vehicleModel = 'taxi',
        pedModel = 's_m_m_gentransport',
        driverAbility = 1.0,
        driverAggressiveness = 0.0,
        drivingStyle = 786469,
        arrivalSpeed = 18.0,
        cruiseSpeed = 28.0,
        pickupStopRange = 14.0,
        autoEnterDistance = 8.0,
        autoEnterFallbackMs = 4000,
        autoExitAtDestination = true,
        autoExitDelayMs = 1200,
        destinationApproachRange = 24.0,
        parkingRadius = 20.0,
        parkingTimeoutSeconds = 10,
        trafficDetectionDistance = 18.0,
        trafficBrakeDistance = 7.0,
        rerouteAfterSeconds = 8
    },

    mechanic = {
        enabled = true,
        label = 'Mecánico',
        description = 'Reparación básica del vehículo actual o más cercano.',
        icon = '🔧',
        price = 500,
        account = 'cash',
        jobs = { 'mechanic', 'mecano' },
        blockWhenOnDutyAtLeast = 1,
        vehicleModel = 'utillitruck3',
        pedModel = 's_m_y_xmech_02'
    },

    ambulance = {
        enabled = true,
        label = 'Ambulancia',
        description = 'Asistencia médica NPC y estabilización del personaje.',
        icon = '🚑',
        price = 750,
        account = 'cash',
        jobs = { 'ambulance', 'ems', 'doctor' },
        blockWhenOnDutyAtLeast = 1,
        vehicleModel = 'ambulance',
        pedModel = 's_m_m_paramedic_01',
        driverAbility = 1.0,
        driverAggressiveness = 0.2,
        drivingStyle = 786469,
        arrivalSpeed = 34.0,
        arrivalStopRange = 18.0,
        trafficDetectionDistance = 16.0,
        trafficBrakeDistance = 6.0,
        rerouteAfterSeconds = 10
    }
}

-- Puntos de integración opcionales. Mantenerlos seguros y devolver false
-- cuando la implementación personalizada no pueda completar la operación.
Config.ClientHooks = {
    revivePlayer = function(context)
        return false
    end,

    healPlayer = function(context)
        return false
    end
}
