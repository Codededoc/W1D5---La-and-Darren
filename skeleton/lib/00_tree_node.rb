require "byebug"

class PolyTreeNode

  attr_reader :parent, :children, :value
    # we're writing our own parent setter method

  def initialize (value = nil)
    @parent = nil
    @children = Array.new
    @value = value
  end

  def parent=(node)
    @parent.children.delete(self) unless @parent.nil?
    @parent = node

    unless @parent.nil? || @parent.children.include?(self)
      @parent.children << self
    end
  end

    def add_child(node)
      @children << node && node.parent=(self) #node becomes child of self, self is now parent of node
    end

    def remove_child(node)
      @children.delete(node) && node.parent=(nil)
      raise  if node.parent.nil?
    end


    def dfs(target)
      return self if self.value == target
          @children.each do |child|
            result  = child.dfs(target)
            return result if result
          end
      nil
    end

    def bfs(target)

      queue = [self]
      # debugger
      @children.each { |node| queue.push(node) }

      until queue.empty?
        first_element = queue.shift
        return first_element if first_element == target
      end
      nil
    end


end
