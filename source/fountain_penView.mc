import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.ActivityMonitor;
import Toybox.Weather;

class fountain_penView extends WatchUi.WatchFace {

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {

        // Get variables for use in view updates
        var today = Time.Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
        var hour = today.hour;
        var userProfile = UserProfile.getProfile();
        var vo2 = "VO2 " + userProfile.vo2maxRunning;
        var hr = SensorHistory.getHeartRateHistory(null).next().data;
        var userActivity = ActivityMonitor.getInfo();
        var steps = "STEPS " + userActivity.steps;
        var calories = "CALS " + userActivity.calories;
        
        // Offsets time instead of using military time
        if (hour > 12) {
            hour = hour - 12;
        }

        // Replaces HR with - if data not available
        if (hr == null) {
            hr = "-";
        } else {
            hr = "HR " + hr;
        }

        // Updates watch display fields
        View.findDrawableById("hourLabel").setText("" + hour.format("%02d"));
        View.findDrawableById("minLabel").setText("" + today.min.format("%02d"));
        View.findDrawableById("vo2Label").setText(vo2);
        View.findDrawableById("heartRateLabel").setText(hr);
        View.findDrawableById("calorieLabel").setText(calories);
        View.findDrawableById("stepLabel").setText(steps);
        View.findDrawableById("dateLabel").setText("" + today.day_of_week + ", " + today.month + " " + today.day + " " + today.year);

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
        View.onUpdate(dc);
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }

}
