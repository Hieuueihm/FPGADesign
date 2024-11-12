import numpy as np
import scipy.signal as signal
import matplotlib.pyplot as plt

# Define the filter coefficients in hexadecimal and convert to decimal
hex_coeffs = ["F1", "F3", "07", "26", "42", "4E", "42", "26", "07", "F3", "F1"]
coeffs = np.array([int(h, 16) for h in hex_coeffs])

# Normalize the coefficients (optional, depending on desired gain)


# Define the input signal: two values of -7 followed by zeros
input_signal = np.array([-7, -7] + [0] * 98)

# Apply the FIR filter
output_signal = signal.lfilter(coeffs, 1.0, input_signal)

# Display the input and output signals
print("Input Signal:", input_signal)
print("Output Signal:", output_signal)

# Plot the output signal
plt.stem(output_signal, use_line_collection=True)
plt.title('Output Signal')
plt.xlabel('Sample Index')
plt.ylabel('Amplitude')
plt.show()
