<?php
defined('BASEPATH') or exit('No direct script access allowed');

class MAbsensi extends CI_Model
{
    public function add($data)
    {
        return $this->db->insert('absensi', $data);
    }

    public function getByJadwal($id_jadwal)
    {
        $this->db->where('id_rapat', $id_jadwal);
        return $this->db->get('absensi')->result();
    }

    public function hadir($id_absen)
    {
        $this->db->set('kehadiran', 1);
        $this->db->where('id', $id_absen);
        $this->db->update('absensi');
    }

    public function absen($id_absen)
    {
        $this->db->set('kehadiran', 2);
        $this->db->where('id', $id_absen);
        $this->db->update('absensi');
    }
}
