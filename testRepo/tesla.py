from car import Car

class Tesla(Car):
    """
    Represents a Tesla car, inheriting from the generic Car class.
    """

    def __init__(self, model, year, battery_level=100):
        """
        Initializes a new Tesla object.

        Args:
            model: The model of the Tesla (e.g., "Model S").
            year: The year the car was manufactured.
            battery_level: The initial battery level (default is 100).
        """
        super().__init__("Tesla", model, year)
        self.battery_level = battery_level

    def start(self):
        """
        Starts the Tesla. Teslas are always "on" but this will engage the drive system.
        """
        if self.is_started:
            print("The Tesla is already on.")
        else:
            if self.battery_level > 0:
                self.is_started = True
                print("Tesla is on and ready to drive.")
            else:
                print("Battery is dead. Please charge.")

    def charge(self, amount):
        """
        Charges the battery.

        Args:
            amount: The amount to charge the battery by.
        """
        self.battery_level += amount
        if self.battery_level > 100:
            self.battery_level = 100
        print(f"Battery charged to {self.battery_level}%.")

    def autopilot(self, engage):
        """
        Engages or disengages autopilot.

        Args:
            engage: Boolean to engage (True) or disengage (False) autopilot.
        """
        if not self.is_started:
            print("You need to start the car first.")
        else:
            if engage:
                print("Autopilot engaged.")
            else:
                print("Autopilot disengaged.")