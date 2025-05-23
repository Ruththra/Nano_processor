#This code to convert the instruction code to machine code

#Function for convert digit into 3 bit binary
def to_binary_3(num):
    if num < 0 or num > 7:
        raise ValueError("Number must be between 0 and 7")
    return format(num, '03b')

#Function for convert digit into 4 bit binary
def to_binary_4(num):
    if num < 0 or num > 16:
        raise ValueError("Number must be between 0 and 7")
    return format(num, '04b')

def convert(instruction):
    # Define the instruction set
    instruction_set = {
        'ADD': '000',
        'MOVI': '010',
        'NEG': '001',
        'JZR': '011',
        'MOV' : '100',
        'AND' : '101',
        'OR' : '110',
        'XOR' : '111',
    }

    # Split the instruction into parts
    parts = instruction.split(',')
    opcode = parts[0]
    operands = parts[1:]

    # Convert the opcode to binary
    if opcode in instruction_set:
        machine_code = instruction_set[opcode]
    else:
        raise ValueError(f"Unknown opcode: {opcode}")

    # Convert the operands to binary
    if opcode == 'ADD':
        reg1 = to_binary_3(int(operands[0][1:]))
        reg2 = to_binary_3(int(operands[1][1:]))
        machine_code += reg1 + reg2 + "0000"
    elif opcode == 'MOVI':
        reg = to_binary_3(int(operands[0][1:]))
        imm = to_binary_4(int(operands[1]))
        machine_code += reg + "000" + imm
    elif opcode == 'NEG':
        reg = to_binary_3(int(operands[0][1:]))
        machine_code += reg + "0000000"
    elif opcode == 'JZR':
        reg = to_binary_3(int(operands[0][1:]))
        imm = to_binary_4(int(operands[1]))
        machine_code += reg + "000" + imm
    elif opcode == 'MOV':
        reg1 = to_binary_3(int(operands[0][1:]))
        reg2 = to_binary_3(int(operands[1][1:]))
        machine_code += reg1 + reg2 + "0000"
    elif opcode == 'AND':
        reg1 = to_binary_3(int(operands[0][1:]))
        reg2 = to_binary_3(int(operands[1][1:]))
        machine_code += reg1 + reg2 + "0000"
    elif opcode == 'OR':
        reg1 = to_binary_3(int(operands[0][1:]))
        reg2 = to_binary_3(int(operands[1][1:]))
        machine_code += reg1 + reg2 + "0000"
    elif opcode == 'XOR':
        reg1 = to_binary_3(int(operands[0][1:]))
        reg2 = to_binary_3(int(operands[1][1:]))
        machine_code += reg1 + reg2 + "0000"
    else:
        raise ValueError(f"Unknown opcode: {opcode}")
        
    return machine_code

#Usage
while True:         
    instruction = input("Enter the instruction: ") .upper()
    if instruction.lower() == 'exit':
        break   
    else:
        try:
            machine_code = convert(instruction)
            print(f"Machine code: {machine_code}")
        except ValueError as e:
            print(e)