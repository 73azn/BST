require_relative 'node'

class BST 
    attr_accessor :root

    def initialize()
            @root = nil
    end
    def  build_tree (arr)

      arr = arr.uniq
      arr = arr.sort
      @root = sorted_array_to_BST(arr,0,arr.length-1,"build")
            
    end
    def sorted_array_to_BST(arr,start,last,init = nil)

      
      return nil if (start>last) 

      return sorted_array_to_BST(arr,start,last) if init
            
        

      mid = start + (last-start)/2  
      
      root = Node.new(arr[mid])

      root.left = sorted_array_to_BST(arr,start,mid-1)
      root.right = sorted_array_to_BST(arr,mid+1,last)

      return root
    end

    def preorder(root=@root,init=true)
           return nil if root.nil?
           puts "\n------------\npre order\n------------" if init
           print "#{root.data} "
           preorder(root.left,false)
           preorder(root.right,false)
           
           return nil
    end

    def inorder(root=@root,init=true)
      return nil if root.nil?
      puts "\n------------\nin order\n------------" if init
      
      inorder(root.left,false)
      print "#{root.data} "
      inorder(root.right,false)
      
      return nil
    end

    def postorder(root=@root , init = true)

    return nil if root.nil?
    puts "\n------------\npost order\n------------" if init

    postorder(root.left,false)
    postorder(root.right,false)
    print "#{root.data} "
    return nil
    end

    def pretty_print(node = @root, prefix = '', is_left = true)
      pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
      puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
      pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end

    def insert (data,root=@root,init = true)
      #initialize the root for inserting
      if init
                @root = insert(data,root,false)
      end

      #sign the new node and return the node
      return Node.new(data) if root.nil?

      #sign left or right based on BST logic
      root.left =  insert(data,root.left,false) if root.data>data
      root.right = insert(data,root.right,false) if root.data<data

      #return the whole tree
      return root
            
    end

    def has? (data,root=@root)

      #not found or empty tree
      return false  if root.nil?

      #found the root
      return true if root.data == data

      #traverse through the tree
     
       return ((has?(data,root.left) if !root.left.nil?) or (has?(data,root.right) if !root.right.nil?))

    end

    def find(data,root=@root)
      
      return nil if root == nil

      queue = Queue.new
      queue.push(root)
      
      while !queue.empty?
        
        root = queue.pop
        return root.data if root.data.equal?(data)
        queue.push(root.left) if !root.left.nil?
        queue.push(root.right) if !root.right.nil?
      end
      
            
    end

    def level_order(root=@root)

      return nil if root == nil
      puts "\n------------\nlevel order\n------------"
      queue = Queue.new
      queue.push(root)
      
      while !queue.empty?
        
        root = queue.pop
        print "#{root.data} "
        queue.push(root.left) if !root.left.nil?
        queue.push(root.right) if !root.right.nil?
      end
      return nil     
    end
            
    
    def delete(data,root=@root,init=true)
            if init
                  @root = delete(data,root,false)
                  return
            end

            if (data<root.data)
              root.left = delete(data,root.left,false)

            elsif (data>root.data)
              root.right = delete(data,root.right,false)

            else
              
                return root.right if root.left.nil?
                
                return root.left if root.right.nil?

                  root.data = find_min(root.right)
                  root.right = delete(root.data,root.right,false)
            end

            return root

    end

    def height(root=@root,height=0)
            return height if root.nil?
            height+=1
            left = height(root.left,height)
            right = height(root.right,height)

            return left if left>right
            return right if right>=left
    end

    def leafs(root=@root,depth=0)
            return depth if root.nil?
            return depth+1 if root.left.nil? and root.right.nil?

            return depth(root.left,depth)+depth(root.right,depth)

    end

    def depth(given_root,root=@root,depth=0)
           return nil if root.nil?
           return depth if root.data == given_root.data

           depth+=1

           left = depth(given_root,root.left,depth)
           right = depth(given_root,root.right,depth)

           return left if left
           return right if right

           return nil
    end
    def balanced?(root=@root)
        return nil if root.nil?

        left = height(root.left)
        right = height(root.right)

        if left >right
          return ((left-right)<=1 and (left-right)>=0)
        else
          return ((right-left)<=1 and (right-left) >=0)
        end
    end

    def rebalance(root=@root)
        return nil if root.nil?
        return nil if balanced?
        queue = Queue.new
        arr = []
        queue.push(root)
        while !queue.empty?
            root = queue.pop
            arr.push(root.data)
            queue.push(root.left) if !root.left.nil?
            queue.push(root.right) if !root.right.nil?

        end
        build_tree(arr)
        return nil
    end

    def find_min(root=@root)
          return root.data if root.left.nil?
          return find_min(root.left)
          
    end

   
end