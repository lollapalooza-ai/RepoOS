from tesla import Tesla

def main():
    """
    Creates a Tesla and demonstrates its functionality.
    """
    my_tesla = Tesla("Model 3", 2024)

    print(f"Created a {my_tesla.year} {my_tesla.make} {my_tesla.model}")
    print(f"Initial battery level: {my_tesla.battery_level}%")

    my_tesla.start()
    my_tesla.drive(60)
    my_tesla.accelerate(20)
    my_tesla.brake(10)
    my_tesla.autopilot(True)
    my_tesla.autopilot(False)
    my_tesla.stop()
    my_tesla.charge(20)


if __name__ == "__main__":
    main()
