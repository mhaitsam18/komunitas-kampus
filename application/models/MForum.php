<?php
defined('BASEPATH') or exit('No direct script access allowed');

class MForum extends CI_Model
{
    public function add($data)
    {
        return $this->db->insert('thread', $data);
    }

    public function getByMe($id_komunitas)
    {
        $this->db->where('id_komunitas', $id_komunitas);
        return $this->db->get('thread')->result();
    }

    public function detail($id_forum)
    {
        $this->db->where('id', $id_forum);
        return $this->db->get('thread')->row();
    }

    public function komentar($id_komentar)
    {
        $this->db->where('id', $id_komentar);
        $this->db->order_by('id', 'DESC');
        return $this->db->get('komentar')->result();
    }

    public function komentarByThread($id_thread)
    {
        $this->db->where('id_thread', $id_thread);
        $this->db->order_by('id', 'DESC');
        return $this->db->get('komentar')->result();
    }

    public function addKomentar($data)
    {
        return $this->db->insert('komentar', $data);
    }
}
