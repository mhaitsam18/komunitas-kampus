<?php
defined('BASEPATH') or exit('No direct script access allowed');

class MArsip extends CI_Model
{
    public function getByTokenKomunitas($token_komunitas)
    {
        $this->db->where('token_komunitas', $token_komunitas);
        return $this->db->get('arsip')->result();
    }

    public function add($data)
    {
        return $this->db->insert('arsip', $data);
    }

    public function delete($id_arsip)
    {
        $this->db->where('id', $id_arsip);
        return $this->db->delete('arsip');
    }
}
