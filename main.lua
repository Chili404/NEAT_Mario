--Matrix "Class" Implementation
Matrix = {rows = 0, cols = 0}
NeuralNetwork = {input_nodes = 0, hidden_nodes = 0, output_nodes = 0}
function Matrix:Create(row_input, column_input)
    local this =
    {
        rows = row_input,
        cols = column_input,
        data = {}
        
    }
    function this:display()
        for i = 1, self.rows do
            for j = 1, self.cols do
                io.write(self.data[i][j] .. "|")
            end
            print()
        end
        print()
    end
    
    function this:initialize()
        for i=1, self.rows do
            self.data[i] = {}
            
            for j=1, self.cols do
                self.data[i][j] = math.random() * 2 - 1
            end
        end
    end
    
    function this:add(m2)
        if(self.rows ~= m2.rows or self.cols ~= m2.cols) then
            error("mismatched arrays")
        end
        matres = Matrix:Create(self.rows,self.cols)

        result = {}
        
        for i=1, self.rows do
            result[i] = {}
            
            for j=1, self.cols do
                result[i][j] = self.data[i][j] + m2.data[i][j]
            end
        end
        matres.data = result
        return matres
    end
    
    function this:multiply(m2)
        if(self.cols ~= m2.rows) then
            error("mismatched arrays")
        end   
        matres = Matrix:Create(self.rows,m2.cols)

        result = {}
        
        for i = 1, self.rows do
            result[i] = {}
            for j = 1, m2.cols do
                sum = 0
                for k = 1, m2.rows do
                    sum = sum + self.data[i][k] * m2.data[k][j]  
                end
                result[i][j] = sum
            end
        end
        
        matres.data = result
        return matres
    end
    
    function this:activate()
        for i = 1, self.rows do
            --Sigmoid Activation
            self.data[i][1] = 1 / (1 + math.exp(-self.data[i][1]))    
        end
    end
    return this
end


--Neural Network Implementation
function NeuralNetwork:Create(ninput, nhidden, noutput)
    local this = {
        input_nodes = ninput,
        hidden_nodes = nhidden,
        output_nodes = noutput,
        weights_ih,
        weights_ho,
        bias_h,
        bias_o
    }
    
    function this:initialize()
        self.weights_ih = Matrix:Create(self.hidden_nodes, self.input_nodes)
        self.weights_ih:initialize()
        self.weights_ho = Matrix:Create(self.output_nodes, self.hidden_nodes)
        self.weights_ho:initialize()

        self.bias_h = Matrix:Create(self.hidden_nodes, 1)
        self.bias_h:initialize()
        self.bias_o = Matrix:Create(self.output_nodes, 1)
        self.bias_o:initialize()
    end
    
    function this:feedForward(m2)
        mat = self.weights_ih:multiply(m2)
        mat1 = mat:add(self.bias_h)
        mat2 = self.weights_ho:multiply(mat1)
        mat3 = mat2:add(self.bias_o)
        mat3:activate()
        return mat3
    end
        
    return this
end

--Genetic Algorithm
function Population:Create()
    function this:Fitness()
        
    end
    
    function this:Select()
        
    end
    
    function this:Crossover()
        
    end
    
    function this:Mutate()
        
    end
    
    
end

net = NeuralNetwork:Create(3,3,2)
net:initialize()
addend = Matrix:Create(3,1)
addend:initialize()
mat = net:feedForward(addend)
mat:display()
