module Nodes

    using Main.NQueens.Alias: Step, Color, ActionId, AbstractQueensSet, NodeId, SetNodesId
    using Main.NQueens.Alias

    mutable struct Node
        id :: NodeId
        step :: Step
        color :: Color
        action_id :: ActionId
        parents :: SetNodesId
        sons :: SetNodesId
        owners :: SetNodesId
    end

    function new(node_id :: NodeId, step :: Step) :: Node
        action_id = node_id.action_id
        color = Color(action_id)
        parents = SetNodesId()
        sons = SetNodesId()
        owners = SetNodesId()
        push!(owners, node_id)

        return Node(node_id, step, color, action_id, parents, sons, owners)
    end

    function join!(node :: Node, node_join :: Node)
        if node.id == node_join.id
            union!(node.parents, node_join.parents)
            union!(node.sons, node_join.sons)
            union!(node.owners, node_join.owners)
        end
    end

    function build_owner_link!(node_a :: Node, node_b :: Node)
        push!(node_a.owners, node_b.id)
        push!(node_b.owners, node_a.id)
    end
    function delete_owner!(node :: Node, node_id :: NodeId)
        delete!(node.owners, node_id)
        #If they arent owners cannot be either parents or sons
        delete!(node.sons, node_id)
        delete!(node.parents, node_id)
    end

    function add_parent!(node :: Node, parent :: Node)
        add_parent!(node, parent.id)
    end
    function add_parent!(node :: Node, parent_id :: NodeId)
        push!(node.parents, parent_id)
    end

    function add_son!(node :: Node, parent :: Node)
        add_son!(node, parent.id)
    end
    function add_son!(node :: Node, son_id :: NodeId)
        push!(node.sons, son_id)
    end

    function delete_parent!(node :: Node, parent_node :: Node)
        delete_parent!(node, parent_node.id)
    end
    function delete_parent!(node :: Node, parent_id :: NodeId)
        delete!(node.parents, parent_id)
    end

    function delete_son!(node :: Node, son_node :: Node)
        delete_son!(node, son_node.id)
    end
    function delete_son!(node :: Node, son_id :: NodeId)
        delete!(node.sons, son_id)
    end

    function have_parents(node :: Node) :: Bool
        !isempty(node.parents)
    end

    function have_sons(node :: Node) :: Bool
        !isempty(node.sons)
    end

end
