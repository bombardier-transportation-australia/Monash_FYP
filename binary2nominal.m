function [ NominalValue ] = binary2nominal(BinaryValue, LSBWeight, Offset, ModuleType)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    %Refer to module types.xlsx for more info
    LSBWeight = double(LSBWeight);
    Offset = double(Offset);
    BinaryValue = double(BinaryValue);
    switch ModuleType
        case {0,5,6,21,22}
            NominalValue = (LSBWeight *  BinaryValue - Offset) * 1E-9;
        case{3,4,7,9,11,19,23}
            %exp
            NominalValue = 1E-12 * LSBWeight *  BinaryValue - Offset * 1E-9;
        case {16,17}
            NominalValue = 1E-13 * LSBWeight *  BinaryValue - Offset * 1E-7;
        case {18}
            NominalValue = 1E-12 * LSBWeight *  BinaryValue - Offset * 1E-6;
        case {1}
            NominalValue = (LSBWeight *  BinaryValue - Offset) * 1E-9;
            
        case {2}
            NominalValue = (LSBWeight *  (BinaryValue - 32768) - Offset) * 1E-9;
        case {15}
            NominalValue = 1E-12 * LSBWeight *  BinaryValue - Offset * 1E-6;
        case {10}
            NominalValue = 1E-13 * LSBWeight *  BinaryValue - Offset * 1E-8;
        case {12,13,20}
            NominalValue = (LSBWeight *  BinaryValue + Offset) * 1E-9;
        case {14}
            NominalValue = (LSBWeight *  BinaryValue + Offset) * 1E-9;
        otherwise
            %same as first
            NominalValue = (LSBWeight *  BinaryValue - Offset) * 1E-9;
    end
end

