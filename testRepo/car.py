class Car:
    """
    A generic representation of a car.
    """

    def __init__(self, make, model, year):
        """
        Initializes a new Car object.

        Args:
            make: The make of the car (e.g., "Toyota").
            model: The model of the car (e.g., "Corolla").
            year: The year the car was manufactured.
        """
        self.make = make
        self.model = model
        self.year = year
        self.is_started = False
        self.speed = 0

    def start(self):
        """
        Starts the car's engine.
        """
        if self.is_started:
            print("The car is already running.")
        else:
            self.is_started = True
            print("The car has been started.")

    def stop(self):
        """
        Stops the car's engine.
        """
        if not self.is_started:
            print("The car is already stopped.")
        else:
            if self.speed == 0:
                self.is_started = False
                print("The car has been stopped.")
            else:
                print("You cannot stop the car while it is moving.")

    def drive(self, speed):
        """
        Sets the car's speed.

        Args:
            speed: The desired speed in mph.
        """
        if not self.is_started:
            print("You need to start the car first.")
        elif speed <= 0:
            print("Speed must be a positive number.")
        else:
            self.speed = speed
            print(f"The car is now driving at {self.speed} mph.")

    def reverse(self):
        """
        Puts the car in reverse.
        """
        if not self.is_started:
            print("You need to start the car first.")
        elif self.speed > 0:
            print("You cannot reverse while the car is moving forward.")
        else:
            self.speed = -5  # Simulate a slow reverse speed
            print("The car is now in reverse.")

    def accelerate(self, amount):
        """
        Increases the car's speed.

        Args:
            amount: The amount to increase the speed by (in mph).
        """
        if not self.is_started:
            print("You need to start the car first.")
        elif self.speed < 0:
            print("You cannot accelerate while in reverse.")
        else:
            self.speed += amount
            print(f"The car accelerated to {self.speed} mph.")

    def brake(self, amount):
        """
        Decreases the car's speed.

        Args:
            amount: The amount to decrease the speed by (in mph).
        """
        if not self.is_started:
            print("You need to start the car first.")
        else:
            if self.speed > 0:
                self.speed -= amount
                if self.speed < 0:
                    self.speed = 0
                print(f"The car slowed down to {self.speed} mph.")
            elif self.speed < 0:
                print("You are in reverse. Use 'drive' to move forward.")
            else:
                print("The car is already stopped.")