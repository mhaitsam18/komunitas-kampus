<?php
defined('BASEPATH') or exit('No direct script access allowed');

class MJadwal extends CI_Model
{
    public function add($data)
    {
        return $this->db->insert('jadwal_rapat', $data);
    }

    public function getById($id_jadwal)
    {
        $this->db->where('id', $id_jadwal);
        return $this->db->get('jadwal_rapat')->result();
    }

    public function getJadwalById($id_jadwal)
    {
        $this->db->where('id', $id_jadwal);
        return $this->db->get('jadwal_rapat')->row();
    }

    public function getWithKomunitas($id_komunitas)
    {
        $this->db->where('id_komunitas', $id_komunitas);
        return $this->db->get('jadwal_rapat')->result();
    }

    public function update($data, $id_jadwal)
    {
        $hasil = $this->db->update('jadwal_rapat', $data, 'id=' . $id_jadwal);
        return $hasil;
    }

    public function delete($id_jadwal)
    {
        $this->db->where('id', $id_jadwal);
        return $this->db->delete('jadwal_rapat');
    }
}
