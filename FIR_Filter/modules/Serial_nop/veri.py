def fir_filter(input_data, coefficients):
    # Initialize shift registers (all set to 0 initially)
    shift_registers = [0] * len(coefficients)
    result = 0
    
    # Process each bit in the input data (assumed as binary string "10001000")
    for bit in input_data:
        # Shift the register values to the right
        for i in range(len(shift_registers) - 1, 0, -1):
            shift_registers[i] = shift_registers[i - 1]
        
        # Insert the new bit (converted to integer) into the first register
        shift_registers[0] = int(bit)
        
        # Calculate the FIR filter output by multiplying and summing
        result = sum([shift_registers[i] * coefficients[i] for i in range(len(coefficients))])
        
        # Print the result for this cycle
        print(f"Input bit: {bit}, Shift Registers: {shift_registers}, Output: {result}")
    
    return result

# Test case
input_data = "00000001"
coefficients = [1, 2, 3, 4, 3, 2, 1]
fir_filter(input_data, coefficients)
