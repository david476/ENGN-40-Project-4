classdef constants
    properties (Constant = true)
        G = 9.81;
        CAM_UNITS_TO_M = [1, 1, 1];
        MASS_KG = 0.038;
        THRUST_UNITS_TO_N = 7.923*(10^(-6));
        TAKEOFF_TIME_S = 5;
        PATTERN_TIME_S = 30;
        LANDING_TIME_S = 5;
        PATTERN_START_HEIGHT_M = 1;
        MIN_THRUST_N = 0;
        MAX_THRUST_N = 60000*constants.THRUST_UNITS_TO_N;
        Kpx = 3.8;
        Kpy = 3.8;
        Kpz = 2.47;
        Kdx = 3.351;
        Kdy = 3.351;
        Kdz = 2.51;
        Kix = 1.3;
        Kiy = 1.3;
        Kiz = 0.5;
        Kpyaw = 2.5;
        SIM_DERIV_DT = 0.0001;
        LISSAJOUS_OMEGA_SCALE = 15;%15 works well for 2d
        LISSAJOUS_SCALAR_M = 0.5;
    end
end
